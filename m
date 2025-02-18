Return-Path: <linux-kernel+bounces-519663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF6A3A075
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95573B65CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586826A1CF;
	Tue, 18 Feb 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otD6c3nx"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5F286A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889798; cv=none; b=Acp8ycQWQeT0HYsnJPItP2gu+LkDInFJaB6l1LJq84Eh7X+RfaLBGTgJeXM2OK/dvg8xM8UUpQIuff8+ujCMKsZRYDhxcJcdBUzGfGxTbVu/QjTC04kElbDfWkA5GBgVniJiyc8yRcNdJS1xLh/gOTn75VCOl6jiBhYpSnBEDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889798; c=relaxed/simple;
	bh=4lW/twvdhE+A+c+wKCSUwMTcipMdqeplNUW6N48zvLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i1FP4YYw48fnu13dpZ1nUI0d/zM7BqY0YNqZ6A9PIT4tK/PBMoeZH+t1UgoBCK6H4FrdYKdZp8vQkRh8WjLJj1QuMU5hDEoIUhFjErHIb9eSn9dlRHhkQAOe5a7snLqHcY6QGkLNTfz1YBSpZqd0Jm6sdkOocpR29it1shiwnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otD6c3nx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--derkling.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e180821aso30588315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739889794; x=1740494594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jel/om40HLmpwtgskjT+Vd7H7nmCr+AlMBVyaul/WCc=;
        b=otD6c3nx+/GXsjAi/FKzW+N3t18Kj3O4klg2vJucjtvtc4kaSd8P7u5NhLaSLz3VbF
         PJTK7TinyOWPFMsE8kT+Bn5OBMqaP7CmhGTrdXxlNetMpBZM6KlUdxALozqAMXyO1AGm
         sixiAEM3ckLRQ48IrGFW64yvZOet76XpYo3a+VHkz/8LzyfqOWE5yZdFJ8jo6dduDVWD
         +iUnEE2NYBkeY9ofU3NE814xUiQO0cwqzUP/AMZ6pKEnzOf+Yis8HuKrLNCAWwuhboFY
         Bnn9cwNwWb1QAEd082ZnjJgE9tLIKFQNcjngkIGhObWVoESBqufP4S5hbB/q3t+QDdHW
         URUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889794; x=1740494594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jel/om40HLmpwtgskjT+Vd7H7nmCr+AlMBVyaul/WCc=;
        b=A5jCmmdnA41I8U/DpJSxzzc9XlamHZ7k2qZBt5N+5sYJQy60UX2OT8Ami1hRLlSrpm
         +XV/PkGA3KMkGvCvzSC3FrXV2P5fFyVCv7pkoZkhDFzmlsw26nFRPQVoVUGamdTGkZBZ
         CzspFXKkLzFzevhtq3SBbOEq7yjCHgGP0F3DPUBCbPOeGzN8hPNezYJQTig92SD4o4gI
         kwSDzdWIUB+tUS+gRdZoKDu9q15LPb5vKobXChJb0IcGeFwsGhx2sXwtdsGUZkmd/KG5
         634L6uFRETpG9HXJ8/T3OXbjmhy9VE4zHkjmRJp3IHR0ldXV8byd9Edc9yXtZuJZWHKL
         Fbmg==
X-Forwarded-Encrypted: i=1; AJvYcCXImoqxmPrkwZokmWQoCVZdUxaiFMwS+Q3i2ryLQeEN2WSgpgZt3Yh1tIOkA6sP6X70q5pZZaIl+eiZyPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6suJRvZ94EUejWoxWykXxd5j9OD8vZOOtJX3a43m93LiFulR
	s4AtlBKAWxPY70+uIf9eEO/1GAIYgQrH0jKk9ZLAILtsyXK/o5a3E9ERvirmI7KrQwaY/ogxPJ/
	Z6Qs7PWo+rw==
X-Google-Smtp-Source: AGHT+IHpYFUhEi3NwetUXZRckhwIr+1DZvrCsLXzKq961BPNu7xrlPpIzMh19VLzq7zt+78SXVccEhyX+T6l1Q==
X-Received: from wmqd18.prod.google.com ([2002:a05:600c:34d2:b0:439:8e81:fd03])
 (user=derkling job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154d:b0:434:a923:9310 with SMTP id 5b1f17b1804b1-4396e701614mr136998375e9.15.1739889793882;
 Tue, 18 Feb 2025 06:43:13 -0800 (PST)
Date: Tue, 18 Feb 2025 14:42:57 +0000
In-Reply-To: <20250218111306.GFZ7RrQh3RD4JKj1lu@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218111306.GFZ7RrQh3RD4JKj1lu@fat_crate.local>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218144257.1033452-1-derkling@google.com>
Subject: Re: [PATCH final?] x86/bugs: KVM: Add support for SRSO_MSR_FIX
From: Patrick Bellasi <derkling@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Patrick Bellasi <derkling@matbug.net>, 
	Brendan Jackman <jackmanb@google.com>, David Kaplan <David.Kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"

> in the interest of finally making some progress here I'd like to commit this
> below (will test it one more time just in case but it should work :-P). It is
> simple and straight-forward and doesn't need an IBPB when the bit gets
> cleared.

That's indeed simple and straight-forward for the time being.

Maybe a small improvement we could add on top is to have a separate and
dedicated cmdline option?

Indeed, with `X86_FEATURE_SRSO_USER_KERNEL_NO` we are not effectively using an
IBPB on VM-Exit anymore. Something like the diff down below?

Best,
Patrick

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1d7afc40f2272..7609d80eda123 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2531,6 +2531,7 @@ enum srso_mitigation_cmd {
        SRSO_CMD_SAFE_RET,
        SRSO_CMD_IBPB,
        SRSO_CMD_IBPB_ON_VMEXIT,
+       SRSO_CMD_BP_SPEC_REDUCE,
 };

 static const char * const srso_strings[] = {
@@ -2562,6 +2563,8 @@ static int __init srso_parse_cmdline(char *str)
                srso_cmd = SRSO_CMD_IBPB;
        else if (!strcmp(str, "ibpb-vmexit"))
                srso_cmd = SRSO_CMD_IBPB_ON_VMEXIT;
+       else if (!strcmp(str, "spec-reduce"))
+               srso_cmd = SRSO_CMD_BP_SPEC_REDUCE;
        else
                pr_err("Ignoring unknown SRSO option (%s).", str);

@@ -2617,7 +2620,7 @@ static void __init srso_select_mitigation(void)

        case SRSO_CMD_SAFE_RET:
                if (boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))
-                       goto ibpb_on_vmexit;
+                       goto spec_reduce;

                if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
                        /*
@@ -2670,14 +2673,7 @@ static void __init srso_select_mitigation(void)
                }
                break;

-ibpb_on_vmexit:
        case SRSO_CMD_IBPB_ON_VMEXIT:
-               if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
-                       pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
-                       srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
-                       break;
-               }
-
                if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
                        if (has_microcode) {
                                setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
@@ -2694,6 +2690,14 @@ static void __init srso_select_mitigation(void)
                        pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
                }
                break;
+
+spec_reduce:
+       case SRSO_CMD_BP_SPEC_REDUCE:
+               if (boot_cpu_has(X86_FEATURE_SRSO_BP_SPEC_REDUCE)) {
+                       pr_notice("Reducing speculation to address VM/HV SRSO attack vector.\n");
+                       srso_mitigation = SRSO_MITIGATION_BP_SPEC_REDUCE;
+                       break;
+               }
        default:
                break;
        }

