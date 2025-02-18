Return-Path: <linux-kernel+bounces-518914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E998A3962F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32E23A331B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A8122AE59;
	Tue, 18 Feb 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfpeJs2+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85C1E515
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868579; cv=none; b=S5tFczMDGjo2c2sWbBLTk7n8CMrs5wDD53v7NlgJ1sa0lZgw0by2UXTRUvSgfQYn0ODlWnlWl46c290aiTTneYtXFzNFYtHrZrz/toci1eKGQreCoaIPx943qDggaFybT9qw/3xmgLEOGYsMMYJ+/V6C0LtqQ3jqpBhx/6nURi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868579; c=relaxed/simple;
	bh=WKs0Dn+7nNQrdZ1Tq1ZH9EkB6hG8pxOuj2h1nVQIaoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5OmmYy18KZYHiIh9NB0N3HOr528pq3OW+TvMRxgKYqzL2ImyA5skJYbPn7ojC9xMLKDk4d5+IGs/PfVHlzwoNda+o+tnv5SN0peNDqZ5ovbdSYskaw65V1aze28hylE12GYHgo6O5GN1ZxsSRrUc8AP1yh6uF5ZITbo+S0sHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfpeJs2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wk3JStDPByaR3KnJ1fmYpfYYbnWQoSxUfAheMthZiPg=;
	b=YfpeJs2+GJUfZOJTiaecPD10Zr4ZAA0OK1zmFbnD5siyj5otqAbo86W/7hjLlnPsqHe+nN
	DsMPHweLTrMU2FTO7GlazYLH0KH1rBlaQsefrxe+TAEwT2u1HPpLrezwKmp8MJSiXgGoVJ
	VvQkb5wb187hx3+WiQsXYtCehD2sLDE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-2NhlvbpiMbCvRil6fll-0w-1; Tue, 18 Feb 2025 03:49:35 -0500
X-MC-Unique: 2NhlvbpiMbCvRil6fll-0w-1
X-Mimecast-MFC-AGG-ID: 2NhlvbpiMbCvRil6fll-0w_1739868575
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2c0aa6d6so1886861f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868574; x=1740473374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk3JStDPByaR3KnJ1fmYpfYYbnWQoSxUfAheMthZiPg=;
        b=sW5rL/KPLdLKu1+f6Bsl3DLUXQ79S73FUzXfO/oX9ZhMf+AVt24VQ7PbfpsoDV+O+3
         iDVWUiDNEwGDS4i1g4YTR4ujVPTRPoLouX9KENBAfOqIG4C0Tjfk7cJmbFRdKjwBav8i
         7C0jo9/KNpSuV1eO1rYEthvJkCjuhYzofh2VkEnbDpggLeLop7w87n9Z/x2Nf3ebSUpZ
         3M8TvhMISlceoA4w0rrkeclqX73daASBD+Z5yHDXjfRaywN13C9GN7RnfZcmSEqKj5tW
         mk0PlxOGShNEKJBhL9jFrLO52WmvvkSN356M0QOFIiydA91Y40GjabhFPTq7Dqka2+yP
         4ViQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYrBPbQBEFq4l/OddAc6ltnDut9tc4PBK+GUa3dnAIz6/qxhR2cQeU/2L+NtuOGJmY7QtRoSofoD61cwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCUUaV0R7iMSwQL/YuCMfvwA2YjSVkGQQXq9J7hkvXid/0rRw
	+SGV29T7eQJPcfu7wmUv0xvMQKHsFLeyaxoSrM30HTi/vysrSRyYiN93bRkprUhJa4jim+O12VR
	Fab0sIRdqmPCylwKcDUPwsaARuGQvc3zH0f/y5AA0mZeLHmEEKVo/P+w36JgfNQ==
X-Gm-Gg: ASbGncvFHYaO1KjxOj/4FM9103hu1NIrLB/eI9pDfSF9slEE1d78ONJSKNEMNPHg6It
	4uOUlARTohD7GJMoxtLcysDXINsZcDALdaQGGsytbRmU8lSEGPfc/NErhyxXmna8Cp5hUkbM5vP
	L8GNlm2DMQpzl12RAX8NDNIwxlyzKB90SDp8IFKdb5dSbV+vAoCjzN57pwZEJRv0S3IISxDJ/oL
	gfHL1sQX8ewyWSoH/L3LMg2niEL6kCnLnQxx99biaRj/Jmn8SbxhhCd8ffgNVZEE27a49ZsN7to
	w05RQygCJQpkedAo2DoV8o7A1zudG/BXR9wPfUC4II0e5P2qlAYrDA==
X-Received: by 2002:a5d:47c7:0:b0:38d:d8c0:1f7f with SMTP id ffacd0b85a97d-38f24cfa3e6mr22870832f8f.9.1739868574627;
        Tue, 18 Feb 2025 00:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4aV9CL+YYvOEopfPFUg399AqsHk/ZEAllC3IFL3w+WqsuPI2P/2sZIPZIEITAqhlJZWAKiQ==
X-Received: by 2002:a5d:47c7:0:b0:38d:d8c0:1f7f with SMTP id ffacd0b85a97d-38f24cfa3e6mr22870782f8f.9.1739868573877;
        Tue, 18 Feb 2025 00:49:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm21290725e9.39.2025.02.18.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:49:33 -0800 (PST)
Date: Tue, 18 Feb 2025 09:49:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/4] vsock/bpf: Warn on socket without transport
Message-ID: <2u3kbhiduy7mxfn33pbbafrbn7wki2wg2rlj473lzuraeigsor@pvnhznevpclc>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-2-994b7cd2f16b@rbox.co>
 <ygqdky4py42soj6kovk5z3l65h6xpglcse4mp37jsmlm6rjwzu@dcntngtsygj3>
 <ff1d32c8-e01e-45e3-8811-eb19a5cb6960@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ff1d32c8-e01e-45e3-8811-eb19a5cb6960@rbox.co>

On Mon, Feb 17, 2025 at 08:45:06PM +0100, Michal Luczaj wrote:
>On 2/17/25 11:59, Stefano Garzarella wrote:
>> On Thu, Feb 13, 2025 at 12:58:50PM +0100, Michal Luczaj wrote:
>>> In the spirit of commit 91751e248256 ("vsock: prevent null-ptr-deref in
>>> vsock_*[has_data|has_space]"), armorize the "impossible" cases with a
>>> warning.
>>>
>>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c  | 3 +++
>>> net/vmw_vsock/vsock_bpf.c | 2 +-
>>> 2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 53a081d49d28ac1c04e7f8057c8a55e7b73cc131..7e3db87ae4333cf63327ec105ca99253569bb9fe 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1189,6 +1189,9 @@ static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
>>> {
>>> 	struct vsock_sock *vsk = vsock_sk(sk);
>>>
>>> +	if (WARN_ON_ONCE(!vsk->transport))
>>> +		return -ENODEV;
>>> +
>>> 	return vsk->transport->read_skb(vsk, read_actor);
>>> }
>>>
>>> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>>> index f201d9eca1df2f8143638cf7a4d08671e8368c11..07b96d56f3a577af71021b1b8132743554996c4f 100644
>>> --- a/net/vmw_vsock/vsock_bpf.c
>>> +++ b/net/vmw_vsock/vsock_bpf.c
>>> @@ -87,7 +87,7 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
>>> 	lock_sock(sk);
>>> 	vsk = vsock_sk(sk);
>>>
>>> -	if (!vsk->transport) {
>>> +	if (WARN_ON_ONCE(!vsk->transport)) {
>>> 		copied = -ENODEV;
>>> 		goto out;
>>> 	}
>>
>> I'm not a sockmap expert, so I don't understand why here print an
>> error.
>>
>> Since there was already a check, I expected it to be a case that can
>> happen, but instead calling `rcvmsg()` on a socket not yet connected is
>> impossible?
>
>That's right, calling vsock_bpf_recvmsg() on a not-yet-connected
>connectible socket is impossible since PATCH 1/4 of this series.

Okay, I get it now.

If you need to send a v2, can you write it in the commit description 
that the behavior changed in the previous patch and so in 
vsock_bpf_recvmsg() now we no longer expect to be called with a null 
transport.

In any case, LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>That is because to reach vsock_bpf_recvmsg(), you must have sock's proto
>replaced in vsock_bpf_update_proto(). For that you need to run
>sock_map_init_proto(), which you can't because the patched
>sock_map_sk_state_allowed() will stop you.
>


