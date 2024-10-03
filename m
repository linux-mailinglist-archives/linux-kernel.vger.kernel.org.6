Return-Path: <linux-kernel+bounces-348876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335D298ECF6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651D91C20CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005C136338;
	Thu,  3 Oct 2024 10:30:22 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21213FEE
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951422; cv=none; b=kGbp5+s10w+fqGhmhLssQys3nTl5eUajUDUTqGWLOBkUEFBt8vYS9fIo4pHkor8pk+pMCBwFb3fCrAWyCKxrwXe87WTVDjymejMXKf/bkAAqB00cZhQ9CtgXvYlJaHiHDbGVIiCcV4tC7f0I+CHYIKlxuheJSYSFEH9N12HVfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951422; c=relaxed/simple;
	bh=3CnxpmtcFFEvhnfq/RUvf6CpLGkRu6oSX7ITGRrh6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y09pAbktGVSm86ztxWVp6uKUypRtnRQF7q7GK6ohCqBRZddqQvs9jK/R5Bluoo5oFZFRpFH2lf4FdvVMrUIrrrnEKFDh2x4WzoENvVKThurNSJ9CLDwFk/cCZXbVXMtHkVF9vVAW302JCQPzjy1zTO7YqVXKzkj5n6j6/vGJIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso981151a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 03:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727951419; x=1728556219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ob1ivIA2vZD2jo/vXYjrOKEgae7y9JnTjJoYmXfa3x8=;
        b=c9Uk5jshWbYuv4udzhtX/+PwTndK2NeIZjFFu2MNy4AN6ZvXPEwWDwME53ECHh4hW6
         8AdWOgl91DIkinK8EBE8FDWBA5Uxsfhg/VxUEhMvHqjPbUmSpu7THqypI6lhdyu0UWLL
         znC/+YW+0Eg1mxo1rUbHcwIWga59cidAZUf3KjZAaDd+iSt7h6nAJfNCuUaXNfo0QkMw
         j+HT8eB4uoqvoyzngyFPcmAlFN8Vwu24TDFoBhin9n86YGp2rGBbnLMZ6K2OnKOVy28j
         2ulbEFFMGrAXXGxftEeLm1+ChvAaxZBXhVlPv6HbAGQQNHyHBx6+2IBvg+pz4ZFQWR9Y
         3RnA==
X-Forwarded-Encrypted: i=1; AJvYcCVvjS/AlCtWFP70nSymfVxY1chyX4C18+hLCjoJ5kL5dgaPpbC0zKLO80dFGjZQTiklorvCqUtfgC9X8Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6VxWxyLufAN8Ozbx/ScNNF0Hpirm7zVJwRrOlkXfG0O43ly9l
	fMHz213L03BF8sl1rNuujopEx+owuxM7IBzNf6QpLjXoE+SHzGkB
X-Google-Smtp-Source: AGHT+IGbIsEjDU588oApcM1pMopvjJo8HPlkahwODhGFTxFQIIDiTNGXk+q2R+6udQvCjYie7kfaGA==
X-Received: by 2002:a17:907:9708:b0:a86:7924:11bd with SMTP id a640c23a62f3a-a98f837b6b0mr610167366b.41.1727951418900;
        Thu, 03 Oct 2024 03:30:18 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a991047318esm66306266b.179.2024.10.03.03.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:30:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: akpm@linux-foundation.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Xiong Nandi <xndchn@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Carlos Llamas <cmllamas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts/decode_stacktrace.sh: remove trailing space
Date: Thu,  3 Oct 2024 03:30:05 -0700
Message-ID: <20241003103009.2635627-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decode_stacktrace.sh adds a trailing space at the end of the decoded
stack if the module is not set (in most of the lines), which makes the
some lines of the stack having trailing space and some others not.

Do not add an extra space at the end of the line if module is not set,
adding consistency in output formatting.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 scripts/decode_stacktrace.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 826836d264c6..4b3502a007fd 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -311,7 +311,12 @@ handle_line() {
 	parse_symbol # modifies $symbol
 
 	# Add up the line number to the symbol
-	echo "${words[@]}" "$symbol $module"
+	if [ -z ${module} ]
+	then
+		echo "${words[@]}" "$symbol"
+	else
+		echo "${words[@]}" "$symbol $module"
+	fi
 }
 
 while read line; do
-- 
2.43.5


