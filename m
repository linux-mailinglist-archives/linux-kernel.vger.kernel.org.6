Return-Path: <linux-kernel+bounces-422616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0D9D9BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DDBB2CBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4361D9339;
	Tue, 26 Nov 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzLhhl+f"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA571D9341
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640070; cv=none; b=qlRKtBvb5o8JVQ3O/3Jm+HrKmj5j3ZYSg66LKSV6CF2vM4piOZeKHe90g9/4yAU39pFRJfubYxw2CiNTfhsKhqprx4ps/ZM4Pm4WSdwmRHCV97nWNx48ZTXJVNfPjJFxCr9CtgwBeEPAE4YZl3eaiPqnEcbr3b7JloSxHeuebc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640070; c=relaxed/simple;
	bh=DIp+sKw/YUR5DOvPGmLkXi+5hSkr25LLRbjXxJw9Sww=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EmkvSn6n6AlcO8oHayFSzqHqfrHPVNfFHU04y0M9ztKzU9e4CWk+pt8N3BTmIEkg0piWcvJVYJVsc+GW6xg3fMxhKLuh7+W5opRKAd7v/sYIkvsX9m8MvQo5c69Ew2iFp21pKW5cz5VDe471J8uz8JXsXkJV3jN8JaICQvgPWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzLhhl+f; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa5438c6b13so180907766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732640066; x=1733244866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVWAMpSCzHg3fGvJUBSfxRuCq7EFAuyV0JzFHGbmGlM=;
        b=dzLhhl+fcO+4h2td232vfisI8ogmKMBrkGUcsB3l/+wydHxr23LGzaeKxsv9SGyGSI
         T7oZjMBUPMDnsCxJjLi6nZECBIcQlL3pkJLYjHduZlNmJRg40qp6cv9OGDlFwYh+0ccU
         Q+Cyq1CaczL3FRLgnohbwX7rwqvxOtZ5SeMOx/Bpz9hn3/itQnfTKYJGhyObQ0H2xD3G
         NCZ4WSSB5N251y38GDYWEUTe8JZBRd+JaDX4wyvk0LCCdysYip/Pr6LTd1grv/c0ShXU
         KcLbplBEqVbxTTrOPgOzYrTuhTplRX+xThj0TkyYDNCXf9QqGJ3rtVjfGg5lwIBMrTcK
         +12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640066; x=1733244866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVWAMpSCzHg3fGvJUBSfxRuCq7EFAuyV0JzFHGbmGlM=;
        b=KLqgGdzR/hQc9+HXgTUEvTYMQcfTROrIPDLykerq84IWN4V+Mp0FWzfubPNfZAdpOr
         XpIg53idggZVhFB5bI0N1yMPSXjhuJBkjKZxDfr3YehNMwProo4g/kFQu/jR3C4xsFTV
         /W1rOutgTd+9GW6hLdbdpIZ99EO/0j4brpIaoSSMmjPNFo//7VKtECBCtDuQIg8SEViQ
         kuhY6nXNThwkit77bz6wUnmpKjtgZq+Dpi+qqFCKFv3VsE9c+94mQJYRUPoYHKkn1zIw
         nP0Woyr8f67zM0nndQ8eIW4+GbAqBszIM69JPBpiHO/dnt9+75lkBRH0izyTWT+2AU9f
         0xbg==
X-Forwarded-Encrypted: i=1; AJvYcCWw8K5qPG+ZIvTkf1SbvJQen2VHqpwnOeohaFXeC6NIWD1aawqzlCfXIGlP1vPjLsBFdO9RqscbBVir3oU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88kOqZJHHL68mP8BHcd9bMM0tgoAPq5w7PRCX7a+DABPEKRZK
	ROOcUP3S1kmmmtEz5Io6kr9YcbE3gnUFGqzIrfROmftO8tCMQNIi9D5aY5nXVnyFZSBQ7lit6g=
	=
X-Google-Smtp-Source: AGHT+IGnQ1RVPZpYNr4V2vsGwSrr1TfgOgeHTUES9Lyk5V8C/M8niDnuj/9jgzaUoqUes4SWLxjdrGEpAg==
X-Received: from ejkk23.prod.google.com ([2002:a17:906:32d7:b0:aa5:1a39:9444])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:30c9:b0:a9a:1739:91e9
 with SMTP id a640c23a62f3a-aa521fdce0emr1032268766b.24.1732640065788; Tue, 26
 Nov 2024 08:54:25 -0800 (PST)
Date: Tue, 26 Nov 2024 17:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126165414.1378338-1-elver@google.com>
Subject: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikola Grcevski <nikola.grcevski@grafana.com>
Content-Type: text/plain; charset="UTF-8"

The warning message for bpf_probe_write_user() was introduced in
96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
tracers"), with the following in the commit message:

    Given this feature is meant for experiments, and it has a risk of
    crashing the system, and running programs, we print a warning on
    when a proglet that attempts to use this helper is installed,
    along with the pid and process name.

After 8 years since 96ae52279594, bpf_probe_write_user() has found
successful applications beyond experiments [1, 2], with no other good
alternatives. Despite its intended purpose for "experiments", that
doesn't stop Hyrum's law, and there are likely many more users depending
on this helper: "[..] it does not matter what you promise [..] all
observable behaviors of your system will be depended on by somebody."

As such, the warning message can be improved:

1. The ominous "helper that may corrupt user memory!" offers no real
   benefit, and has been found to lead to confusion where the system
   administrator is loading programs with valid use cases.  Remove it.
   No information is lost, and administrators who know their system
   should not load eBPF programs that use bpf_probe_write_user() know
   what they are looking for.

2. If multiple programs with bpf_probe_write_user() are loaded by the
   same task/PID consecutively, only print the message once. If another
   task loads a program with the helper, the message is printed once
   more, and so on. This also makes the need for rate limiting
   redundant.

3. Every printk line needs to be concluded with "\n" to be flushed. With
   the old version the warning message only appeared after any following
   printk. Fix this.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ead3d66f8db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -359,11 +359,16 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 
 static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 {
+	static pid_t last_warn_pid = -1;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
+	if (READ_ONCE(last_warn_pid) != task_pid_nr(current)) {
+		pr_warn("%s[%d] is installing a program with bpf_probe_write_user\n",
+			current->comm, task_pid_nr(current));
+		WRITE_ONCE(last_warn_pid, task_pid_nr(current));
+	}
 
 	return &bpf_probe_write_user_proto;
 }
-- 
2.47.0.338.g60cca15819-goog


