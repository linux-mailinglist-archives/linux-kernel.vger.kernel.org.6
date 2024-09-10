Return-Path: <linux-kernel+bounces-323112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5B973818
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509EA1F258C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D72D191F7C;
	Tue, 10 Sep 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj9Aao9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35A1EB2F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972960; cv=none; b=QgFNX1uBI5l/vmP0Exfddj6Eok3oxjh/YdyHbJWUX5+/oAdOIpjaFpj7xJaUm6L+3e/EIL3aDom/xHoWyOcQzn7c3Ne9muYYkUdWNRJVw/0mg1CAVNXLyCmsTn8UKQoSofR8ygR+6sip9PLupbHG0w1Y5mOkjoZXbhs1pBJkClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972960; c=relaxed/simple;
	bh=AqkcBFwGVLj2bY+gxMbHkm/wPP2Q8ggLrpw5VF0hUP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KUlHM5QPgTZ5ybeZo8VxdeX1yvJ0v/BsmgxlJN2O1Pmz66QMTyftNk+QER8YL6RmArgoph3sOziFDYs8S4A0pwOUk2+O7DW2nFFSMF7NxEXpwQTjtB/iF1T1xDWEg2EsI3HsMZ7TzR94OY1CmMYikllp0w2gfOcU1UOnJNSyEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj9Aao9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAD1C4CEC3;
	Tue, 10 Sep 2024 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725972960;
	bh=AqkcBFwGVLj2bY+gxMbHkm/wPP2Q8ggLrpw5VF0hUP8=;
	h=From:Date:Subject:To:Cc:From;
	b=Lj9Aao9lwd1wXqinlGSpS3YTiN5I9lDkEF+oVCFYjA0ERCd6du2i/KUSUUs/xU3HU
	 M2mdg8pm+FzCQNI/GdY7XKDfhI7OOhzKP3OMeMWOazFOHCBpBjZ73hBtn3POZ9vQnz
	 Chr4dtk3/qi3cY0axS0lAUiZzjga2vaSZGw6hMAie/dXeibuYVm6bR2fjMWi8Hp43e
	 MpwGm1WJZiBTNoBszyrYMsM6Lf16KilM3H5lKT5HXHzScquB/RDuIYPoB525efeS6y
	 hcc7ebgi36ok3lD5MoYM0mmPe7L9Geb3LYBmxH1vXC04zY7F2lL96Zy1eyF0KKT5LM
	 baU6pfI4Z4nEg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Sep 2024 08:55:39 -0400
Subject: [PATCH v2] timekeeping: don't use seqcount loop in
 ktime_mono_to_any on 64-bit systems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-mgtime-v2-1-e96826ac56f0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMpB4GYC/2XMQQ7CIBCF4as0sxYDtNjoynuYLigd6EQLDTRE0
 3B3sVuX/8vLt0PCSJjg1uwQMVOi4GvIUwNm1t4ho6k2SC47fhWcLW6jBVnfCtQGe2O0gnpeI1p
 6H9BjqD1T2kL8HG4Wv/WPyIIJ1io7Xrpx4tqq+xOjx9c5RAdDKeULCb74hp0AAAA=
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AqkcBFwGVLj2bY+gxMbHkm/wPP2Q8ggLrpw5VF0hUP8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm4EHafXzJcnJMwiBiUVpi1SlMtgOGFjrtisudv
 8CArxw7kgeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuBB2gAKCRAADmhBGVaC
 FdwgD/sGWV6I8rodkOK3fqvZs85TzXeYRffwAykTMlmo0owuhUmTSjBXRWj118W8mIFOuPI3VHg
 Kfr8JeKqzCJ+eaTm9lEuLzV7D13aZ5MSm+8Cs7pwj3r0XXWyvc+spTwfG7i94DTFvcsn3ipPgRo
 C3z8vU8eFHTiVIIGyylFxYFHJfQKN1fABy8D2+LE7oFWBSdzNh0TrS6eVuPPsXy6bZR4Y8vTSFt
 tQDj/CJ5vgDTAh/muP2u2xYba47n6O/SM0/gTH5bpqz1/nqNroOwOdHl67KiSAGlaPcBW9jn5g0
 2b6JfzdbhVLS2AJg7fMIocOWvz763UHB7/B5gljWtslMwrjFjE6ZhEfcOkEVcHqDAvoejdteXSr
 2CjYots2y9tGwaAT2m2DW7VmPdRAeSpcfYFS67dwy/kRohNvJ7X3JQmXOJSIy0eqKR8aI/WERVs
 4acQaZwrGXmvTYe/pmOAg/+C0m/i6Wn73NyhMFXVl4iN20TVZkxbL3I2ELfCInCL3X5EZCI1DzL
 GX9PZ8Y2leGmF6LkBgOuEcJ8ZJYPJrsTD68HT4FGSOPM59LFbVTeOC108cJDGHlazWom5KYgbMT
 tOmvVv4xPPHKOsTJQLmvvdl5yH+ZtFbFG32xN+vHE6Mf8ooYQQo18FBQyYmfGctou0skyHQErHj
 KMTig/qF0Lngu/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

ktime_mono_to_any only fetches the offset inside the loop. This is a
single word on 64-bit hosts, and seqcount_read_begin implies a full SMP
barrier.

When BITS_PER_LONG == 64, just do a simple ktime_add instead as there
is no possibility of getting a torn offset value.

Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Thanks for the review so far, Thomas! Hopefully this looks better.
Disregard my earlier question about making this a static inline too.
That would require making offsets[] a global symbol, which I don't think
we want to do.
---
Changes in v2:
- drop the READ_ONCE
- clean up changelog
- Link to v1: https://lore.kernel.org/r/20240910-mgtime-v1-1-35fb64bd0af5@kernel.org
---
 kernel/time/timekeeping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3f524d43d685..a3872f087fbc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -946,6 +946,14 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset_and_floor);
  * @tmono:	time to convert.
  * @offs:	which offset to use
  */
+#if BITS_PER_LONG == 64
+ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
+{
+	ktime_t *offset = offsets[offs];
+
+	return ktime_add(tmono, *offset);
+}
+#else /* BITS_PER_LONG == 64 */
 ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 {
 	ktime_t *offset = offsets[offs];
@@ -959,6 +967,7 @@ ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 
 	return tconv;
 }
+#endif /* BITS_PER_LONG == 64 */
 EXPORT_SYMBOL_GPL(ktime_mono_to_any);
 
 /**

---
base-commit: dc8f9bbf6ceb160c7fc5e1a03c5a9318cb61bbd7
change-id: 20240910-mgtime-731eace7cca5

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


