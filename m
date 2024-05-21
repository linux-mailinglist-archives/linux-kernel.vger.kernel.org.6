Return-Path: <linux-kernel+bounces-185350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E58CB3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD10B22B45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6012D14900F;
	Tue, 21 May 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ayD/YF31"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85926AF5
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317293; cv=none; b=rxYX/mcHRM9BR4K5wptrOWWYwqBOMXt0HxX3VcjeBwlFRfB8SmkuFc0AB7Y7lvOxFKFVKjyge+KSeCDZJYThoU5nodzpP4v6BWXnGCoOORVFQ2gXOroAxvZYDRRbrV0+9LedkLyvOti1gcMyfqRMWUi5J2wGfpnLKgMPzqjmR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317293; c=relaxed/simple;
	bh=LNVqPFrD15mPoYptpTPAV/FgXo4EuDLhS2IHIgpVvVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zk8XxrQ6eS2WW+srNq01ZDbVCcyAaiEZFjsQ3YGgBnGTatIH/tcjyqypybCzJYkcVES+3BonM6LvIFwj7GXHs0C9b5sCskrLw0GF0fidrcbM142AjJwUV/tF4DWlfvQKfbC4zFpTIKZEAoHgyN3QQppVzK8WuchxGyGSkarnjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ayD/YF31; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a0e4b773so878529266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716317290; x=1716922090; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBBomwXn0DM772nuekwi6UD6QZQUxUGf+kbYusNDyPI=;
        b=ayD/YF3115BrqUUzwEzRCv6B4c/SjgTh1R84kInti8wY+nmDiIDNrre4Jq/dQJAv6/
         Dux5BQh6TCKEejQY4P0Hdd2fezHhlpFVqblIHl/MVnWRyWEERJuRQwbwXik90cgi56h9
         Pia0xrXmYECixJi+c7ZY4AB4qah089tZKhoWZ6p/tlUiV9QF8QBU+gyPiBpGuVHrfrzq
         /7Jo89p9nXQyrzSbIevd4X8mfWo6z1+wDMJVBIZFw6NhgPAdqJoizd0KUW5lrBNNIWAi
         Q6yjsWfzKNVO/Apoe4ZFM64ifyfxc/+QmXhAODbmoq5qh6ouB3pYBVg5qvaipHcgOTDM
         fLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716317290; x=1716922090;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBBomwXn0DM772nuekwi6UD6QZQUxUGf+kbYusNDyPI=;
        b=iBk/nHPx4uIi0qh3iYHDzJj97xcqBoECuFI7AF/ZmtdzvJjIYK1gHi4u6xMB99seEG
         ZnzVI3B47iTdG2cNT5X2htBbTCqbLgskZ78UQELhpNNQP0hTGMDVx6rQ3TGH3k1K8mbo
         E6M4BBlG5wbJPswLQd5YMg8A3+JzLaIwYkp/LcZq1sOhWhDRL+NWutcUfc178qUgTnFX
         n+fddvppI68XGPpouEMvpt5DRzv9BKjbIrq6J4FVlwzN1M6L3iEp/UxT3sKIBvE9o2jc
         ymBLm8nmUgZttmWvMdPYHGh+62Qq4qz/t5A2SpNbjaHSwMsN2jpB8kfdhYcO5VuQQdRy
         U33g==
X-Forwarded-Encrypted: i=1; AJvYcCVqydwZ2kEvzsCxc5mysRsOD/F5H9Dir8EC/IeJqm/rnAOEkUmf+2Xv49o/vmgCd1ykPoDry7T50TNkIkvr5cwMub/IT7vB7bU8ekBP
X-Gm-Message-State: AOJu0YwBahsum8TUl7xMJVgg222UQyQWvPlqm1Gfx8V8AN8W3+Jq3uaD
	k5qcN4gT38kBXFnOFUpZ8phVGmLM6mTPR2ML/F+YHF18YRiD8sSgW2CAW7FE/5E=
X-Google-Smtp-Source: AGHT+IGwzI5vKnF5RscLl5qzclGErCciKuC7xjKohu60VtKLxkJ4nTDhs+enXEqJCFYG+J00QOQiTQ==
X-Received: by 2002:a17:906:81d8:b0:a59:b784:ced5 with SMTP id a640c23a62f3a-a5a2d6797f9mr1904402666b.67.1716317290430;
        Tue, 21 May 2024 11:48:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a7b53fc8fsm1049418566b.38.2024.05.21.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:48:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
Cc: andrii@kernel.org,  ast@kernel.org,  bpf@vger.kernel.org,
  daniel@iogearbox.net,  davem@davemloft.net,  edumazet@google.com,
  john.fastabend@gmail.com,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  pabeni@redhat.com,  syzkaller-bugs@googlegroups.com,
  xrivendell7@gmail.com
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in
 sock_hash_delete_elem (2)
In-Reply-To: <000000000000d0b87206170dd88f@google.com> (syzbot's message of
	"Fri, 26 Apr 2024 23:08:19 -0700")
References: <000000000000d0b87206170dd88f@google.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 21 May 2024 20:48:08 +0200
Message-ID: <87jzjnxaqf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..f6e694457886 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8882,7 +8882,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -8988,7 +8989,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -8998,7 +8998,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&

