Return-Path: <linux-kernel+bounces-302835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645D9603FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC5B283967
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED213D53F;
	Tue, 27 Aug 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="giF+cKXi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F00158D79
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746103; cv=none; b=TB5MIwxVzl4LQG4dWXNjj0QLtoszf8HbXEcWuyn5poKvx2kzYoZ1yNfbbHKYM1waYbLCyJ/JbnRRewN96/tDiPW7HeKCewQZD/ifL+6Yqxht1mdAJy9iyY+JWrkruemppVDbllngSLoF5UG/1p4jZBCdRlERQBvVcurrvPG13JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746103; c=relaxed/simple;
	bh=XK9OQMQTFxQ0v24Z7CPmfIFrzaLyz3iViQ/mA4nCuSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMB95IYUo6s5wAl5sYdptKfLA19ZtG2Zz1avFcbe3PDsWVRfy9BPqqyr795hxmCxsBngEVmlVMOEqMl/WdMJpOwCWSHV0wRXfZHbR7W0tFcvBFIYRpWzaUtApPGmqm95ifFDIdLQBKXQIBge0LGazqk8wMpRFZQ4LkdFVqAdEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=giF+cKXi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-204d391f53bso14437575ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724746101; x=1725350901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBmmq+RkgFyfA69KcoqEDgnXhsBnLaX1J/E8wRgNqfo=;
        b=giF+cKXiCnP0SV/gEJmLcoCoxoA/9BbBA2SMMK99futhz+ZQ4RcY9yOM6WEevvvBQB
         QWm2fvJdAj6rNfPfL68Pgt/Iby8ncT/i3S7/PoocFQ28Oqmo4GRS1TS6OgKj6MhEIgBL
         F1IXUhMLL+HALBsyZmv46r1JOeT8hOZUEi06EeqbfSzxHMyeiVWQMA5+gM8B1oDFGRXs
         BrdXO0x0jGSVY4BJjYYQHIRO1NihSkbVocqOakYXHOH+2VAD9b2KqNMqTgQsO4ssZn9c
         TsD6L241K/9IYNzQqH9JnUUlS08ZHMFKWDuvfULbxza4UdGFCLG95yIIp6uHAl5DwPYA
         ojRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724746101; x=1725350901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBmmq+RkgFyfA69KcoqEDgnXhsBnLaX1J/E8wRgNqfo=;
        b=iufCD5GXXGygyppi8AHIGAQwNvI7gCxA6UP1Pt2lp4/6HUTSbzrYmsKsn5SEz7ZdCG
         4pfh4QeYJnIKQ4KaqTwIRgMEbdkWWm14k1r8OV4WjtErWVWFPa7fMIsm8xNNLNsPiSG3
         +smV/rw4vGJKzgmGewYOT0kU3hyzY/IYclnfox6n14f+HZ40OfE8ckOHl7eUizmi1MYT
         iQQKr+TsDqafdq0Fj3Mw0hCN92ib4aYLLWmnPDUL9EIhWp20axSqvX3I9ebqj/wSBd+y
         ypolDx+oLGGSns3H/y5JYdowDKbl7B9U9nYOTMUX4a8rEK6EGSV94l9sFqVixjSXLvl1
         YWgg==
X-Forwarded-Encrypted: i=1; AJvYcCUcE/68KKPW+RNyIxfJQh2eeG7A+x/d8hFNAdQYmWuXkim8hSYXlGx3ImFy98zFzQ0PFXfvABoWzph5SrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmVWkGqZgtcT6IUtI08QxUpsfV+0W/yUkLekr6wAa1yrW1QxIN
	dpCTmVH+SbIvrzZyzWPosSnNBHXHIIjAC5dtkeALIoR2yF8/HzivUeDm/n3tZuU=
X-Google-Smtp-Source: AGHT+IEFCmjJp/BUBp3nSBjKs2X74VGhP6YzGHSQdAROniu1iwOmNmyBGIa9qAYNb6Cp6vkBJF0I5A==
X-Received: by 2002:a17:903:1210:b0:202:3e32:5d3e with SMTP id d9443c01a7336-204df47e6f6mr23310875ad.36.1724746100735;
        Tue, 27 Aug 2024 01:08:20 -0700 (PDT)
Received: from [10.68.121.74] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203856099efsm78338535ad.200.2024.08.27.01.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:08:20 -0700 (PDT)
Message-ID: <6c75215b-0bdc-4b5a-b267-6dce0faec496@bytedance.com>
Date: Tue, 27 Aug 2024 16:08:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to
 tos not take effect when TCP over IPv4 via INET6 API
To: Eric Dumazet <edumazet@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
 <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
 <173d3b06-57ed-4e2e-9034-91b99f41512b@linux.dev>
 <CANn89iLKcOBBHXMSduV-DXYZfDCKAZyySggKFnQMpKH3p_Ureg@mail.gmail.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CANn89iLKcOBBHXMSduV-DXYZfDCKAZyySggKFnQMpKH3p_Ureg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/24 02:53, Eric Dumazet 写道:
> On Fri, Aug 23, 2024 at 8:49 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 8/23/24 6:35 AM, Eric Dumazet wrote:
>>> On Fri, Aug 23, 2024 at 10:53 AM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>>>>
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
>>>> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
>>>> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
>>>> use ip_queue_xmit, inet_sk(sk)->tos.
>>>>
>>>> So bpf_get/setsockopt needs add the judgment of this case. Just check
>>>> "inet_csk(sk)->icsk_af_ops == &ipv6_mapped".
>>>>
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp@intel.com/
>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>> ---
>>>> Changelog:
>>>> v1->v2: Addressed comments from kernel test robot
>>>> - Fix compilation error
>>>> Details in here:
>>>> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
>>>>
>>>>    include/net/tcp.h   | 2 ++
>>>>    net/core/filter.c   | 6 +++++-
>>>>    net/ipv6/tcp_ipv6.c | 6 ++++++
>>>>    3 files changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>>> index 2aac11e7e1cc..ea673f88c900 100644
>>>> --- a/include/net/tcp.h
>>>> +++ b/include/net/tcp.h
>>>> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
>>>>                                               struct tcp_options_received *tcp_opt,
>>>>                                               int mss, u32 tsoff);
>>>>
>>>> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
>>>> +
>>>>    #if IS_ENABLED(CONFIG_BPF)
>>>>    struct bpf_tcp_req_attrs {
>>>>           u32 rcv_tsval;
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index ecf2ddf633bf..02a825e35c4d 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
>>>>                             char *optval, int *optlen,
>>>>                             bool getopt)
>>>>    {
>>>> -       if (sk->sk_family != AF_INET)
>>>> +       if (sk->sk_family != AF_INET
>>>> +#if IS_BUILTIN(CONFIG_IPV6)
>>>> +           && !is_tcp_sock_ipv6_mapped(sk)
>>>> +#endif
>>>> +           )
>>>>                   return -EINVAL;
>>>
>>> This does not look right to me.
>>>
>>> I would remove the test completely.
>>>
>>> SOL_IP socket options are available on AF_INET6 sockets just fine.
>>
>> Good point on the SOL_IP options.
>>
>> The sk could be neither AF_INET nor AF_INET6. e.g. the bpf_get/setsockopt
>> calling from the bpf_lsm's socket_post_create). so the AF_INET test is still needed.
>>
> 
> OK, then I suggest using sk_is_inet() helper.
> 
>> Adding "&& sk->sk_family != AF_INET6" should do. From ipv6_setsockopt, I think
>> it also needs to consider the "sk->sk_type != SOCK_RAW".
>>
>> Please add a test in the next re-spin.
>>
>> pw-bot: cr

Thanks for your suggestion, I will add it in the next version.


