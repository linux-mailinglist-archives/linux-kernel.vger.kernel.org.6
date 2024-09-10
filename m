Return-Path: <linux-kernel+bounces-322968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405CE97360C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DA32858A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9918C912;
	Tue, 10 Sep 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH1WAzxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCD14D280
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967059; cv=none; b=DRN6KqKEPJyy1a3BM6XrkyHXCn4bS9Z9a9r22cVF19MrqV6duOv0ATPatarFiwd9REnrUgEg8czecc7Ip7Vvw8MjcYJFiAyZXs7+1KGt0IKJxBEqNfol7Dq/2FWXulR2U6bWiAAmDy+IopNaNGI5CGz0nf0CJrFp+M9lXL5pXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967059; c=relaxed/simple;
	bh=P97tC9j046MEsDsgpQ0KZni/NUtZVkdI7VVaaryFMgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bSXOQFkZl6SFjZD4lsdJZGhwWqKWzP1z6w4sPnHrNTAWc+UIjvC5f6vl7+p9jUbYCSTnUyz6vUqTBfA7vnAhBIXK5lbtIeqTBHrGMqhK2NF6+wvC3fHhmdJrb4d1FWPkMNLlK936Aijn0kYHDmFQqMkqhPMGkkEeoxpo2l1+MFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH1WAzxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F287C4CEC3;
	Tue, 10 Sep 2024 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725967058;
	bh=P97tC9j046MEsDsgpQ0KZni/NUtZVkdI7VVaaryFMgE=;
	h=From:Date:Subject:To:Cc:From;
	b=FH1WAzxULMGJBQHv9xC1oSZ7VtJlGF2pxbyvE8nwjj6V/LSMWXqQhadpvs7BKS5b3
	 Ncq6QDyswAbnDX0aNZZUA2+gYhRBZzUNIxVfp4WHLPVtQAKue1Jdk9HiAJVa3aFtpf
	 en+1twikaJayrBbRPExUPkZoh2yWtzzmQPvre6nOa1U7uTDtXBNFMEEy7+DQHFdhgJ
	 hi3nU1f6fURkM1PgyuVCBHeGRj09qmacAEhDvu1rOg/nNX/WZTIIUZi7GL/idZFrHt
	 GUp0Pac2NB4SvqdVAcwAwSyErqj851OnXZwYPLzTgc4tKtg2+cpeFVjv8slrqsJB7L
	 H0F1/MA23aGXQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Sep 2024 07:17:32 -0400
Subject: [PATCH RFC] timekeeping: don't use seqcount loop in
 ktime_mono_to_any on 64-bit arch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-mgtime-v1-1-35fb64bd0af5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMsq4GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0MD3dz0kszcVF1zY8PUxORU8+TkRFMloOKCotS0zAqwQdFKQW7OSrG
 1tQAto/AmXQAAAA==
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P97tC9j046MEsDsgpQ0KZni/NUtZVkdI7VVaaryFMgE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm4CrSuBVhWT3thsOcRyWUinoIvSkpuvmV9JEsF
 zBwu7Dy8LeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuAq0gAKCRAADmhBGVaC
 FWDQD/9NdHa8SF95E/bMIybAqatIvWZd3dyiQ+fwxCPn5cmo25494zdHqXFcndJQePCb5wAnFL3
 LRM+8CbDR+XkuO/+MTshqU22htXDfruNzn8xIDPBoZXdYxKGZhQmWQgnyCJO8SkdFVlQdeFynHH
 tYmzWza0FebOHYbAqxQAYwBl1xAZ0YSfXNIO5w6Euq2qXRyODVPA4ABsYFSoRVsVXJAAmLpcRAG
 MPU4vj6YXFzEqb+SmysqNYGaDv6HcKG48vF7GRMj6aSXGNNnA0pfpMEUw/gLJHBqPdTpaBgIKsv
 g57StNXxLP+0bMdou8TJulGSeN8oxuur3MTgKgvYwxcpQYnmZkyVnoQtu+Hv7abBYcGJgnMwoNp
 oq0ZUMqG3u0dGxveScxSCiQK9XhChGvVRHV3FnbnL3aBk57yEDWPTaf5cl8Xa7GZEGTxwXKL1ie
 CWr88NnQo4N9WDeu2NNp6uVdKLdbWjP0+b4Tbyzvx4azq95NQojOzMbu1kXD8aM8S42dVVppD+C
 rR2pIXegZP1bHiRijrrKevv+/7XypmdntUrIburtzKco4CbqqeYqXhHlwwsuVM+FFr4MLSImFf/
 sjXO1enuY/4C3JpUkdlDgbwyg2wOJ8NDRzj1VdBfwlcalJgc7e5LK1/gpc05vyocFuN2FCO3oEb
 6YIwF6bwZEH7sRQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

ktime_mono_to_any only fetches the offset inside the loop. This is a
single word on 64-bit arch, and seqcount_read_begin implies a full SMP
barrier. While we do want to use the latest offset value available, a
full seqcount loop is overkill on 64-bit, where there is no possibility
of torn reads. Just do a READ_ONCE for that and don't bother with the
seqcount.

Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/time/timekeeping.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..0693f44e064e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -924,6 +924,15 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
  * @tmono:	time to convert.
  * @offs:	which offset to use
  */
+#if BITS_PER_LONG == 64
+ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
+{
+	ktime_t *offset = offsets[offs];
+
+	return ktime_add(tmono, READ_ONCE(*offset));
+}
+EXPORT_SYMBOL_GPL(ktime_mono_to_any);
+#else /* BITS_PER_LONG == 64 */
 ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 {
 	ktime_t *offset = offsets[offs];
@@ -938,6 +947,7 @@ ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 	return tconv;
 }
 EXPORT_SYMBOL_GPL(ktime_mono_to_any);
+#endif /* BITS_PER_LONG == 64 */
 
 /**
  * ktime_get_raw - Returns the raw monotonic time in ktime_t format

---
base-commit: 79d4f9eb4a3c4c68736d500025423e96e212b13d
change-id: 20240910-mgtime-731eace7cca5

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


