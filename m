Return-Path: <linux-kernel+bounces-185902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F168CBCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B4B2170B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5B7E56B;
	Wed, 22 May 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LjOqOWgK"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140127E79F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365557; cv=none; b=fak3gmHMggIfA/9fsldlQ0+FARlDpTSRDnc53z4QfPJPFpXM98sjmNDOtYhz1qRdusla5iZ2leXIHDwWl4aHLpWTo4IJrY0y4Ol9aDJFB98Y6fBEJgTkt0MVCd8/nVNh1vNE3YECQPWueA15S3Aoo5zvMW6+57Lx5/mNGcmQKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365557; c=relaxed/simple;
	bh=vk3R4KQmfANWHCtH/ne6qcs8DBfl3MeC7hEtlJRxLJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIqwDm743oVWspeS1eUnF/U/APT8S85k8WBQcvkETb0a20B5ftdGd/Ua2KFjlcezRAVEn48cx41KvK/oYHKOm/gy4znOUTobwWOjZTfYQKCY6zwGLOC31nV9/5QT1+/xV+S6nLlOeAn4y4IpjFq2PwSojD5/RybVd6LmaLGGzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LjOqOWgK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57825ff689bso1726954a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716365553; x=1716970353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq/162D2wbBA4dLFrzt19khbj/72lrfhJsWvQj91jBo=;
        b=LjOqOWgKNDU8JsancRPMx0hepDLcJb7jbQ60/H1Q2+gxunpYOSJT61D//FlrSYZZ82
         0yhvvcO/fiZkI0zfxZtLEninHPSD4u2Hu9Uj99b9t/+PPQlWsN6MEtcxMvdrPMDCp3Bi
         xHQNzWwP8C1VkpvA6pWMmtO6lY9JfJvsXSqXhj4OjA9y7cmHwJPNnAfLfRKiCAa77ZJy
         fq40YgEtvVfrthKyH6rnNqEZHe8L9SaEDSCH1QdUQQ+7yx5kCOSvZYAihhKPpq+HmHA2
         0eZilSCV/5+O9rayLL0yTIHiPUkSQ0blz3q/6kcR6+MP42x+K6beHf2UVv6zrC1Lupc9
         oVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365553; x=1716970353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq/162D2wbBA4dLFrzt19khbj/72lrfhJsWvQj91jBo=;
        b=b6u5wFsC3ZuDiEQtAYbbreV+7SisCdQGsWLJBGShDttz7BOCkLrIB8PNHP7Ea0uUQ5
         Tu/9kdVi1BxFXw7+XLij0iMsPDFzGWQUykYY22iflDIUOzKYMyzgek15CS7ihp4fxAI6
         Q66qiA0uIrsI1AxG4oIis8KsmnVTXe4mNd/o5/m0c7dwMDiSMiX3DG6BXuLP6zXC8bz2
         DkAFD+kAMmxTkP2TDUGxRc65iZOPtF9gnFVblA1r3YwtNzAfWRvjUpFnicPp+cxAlbAg
         bOBAHQ6ufj3eoi+Ql9twaH0tdaddDpZ2EUP9V44KpMgvuMOwcoc/7SR64vl2ubvqPmrF
         u3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJQDeumQ9TWRF4fvMQx4pDo8nBdJN+DL9tR9TibC99lJnYDDvYGmi0/vh8g92oF4OCrOVXvYN/w93jjIJCjNkni6TLLFAGG90NdbYN
X-Gm-Message-State: AOJu0YxEiYqc0BDbj5/lhX4CFeuoRgkKnk48M5APQgydAXCe1AVUK3jQ
	goQln/DmvDbS8OWV/duvwqxRkUJkuSubLipeL75FIFo4598uYR6phpEhIl4TPX8=
X-Google-Smtp-Source: AGHT+IFmGsT5K8VSmmgd8IG9bBCFaCKxwzGK4lUKVOSdutPIUuQU+nsgWONTZd2FTHrPdyDKP/mxVA==
X-Received: by 2002:a50:99d0:0:b0:574:eba7:4741 with SMTP id 4fb4d7f45d1cf-57832c641bamr691855a12.42.1716365552935;
        Wed, 22 May 2024 01:12:32 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5782859f7ffsm1464361a12.83.2024.05.22.01.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:12:32 -0700 (PDT)
Date: Wed, 22 May 2024 10:12:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	larysa.zaremba@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ila: avoid genlmsg_reply when not ila_map
 found
Message-ID: <Zk2o7nmCfQstc7LP@nanopsycho.orion>
References: <20240522031537.51741-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522031537.51741-1-linma@zju.edu.cn>

Wed, May 22, 2024 at 05:15:37AM CEST, linma@zju.edu.cn wrote:
>The current ila_xlat_nl_cmd_get_mapping will call genlmsg_reply even if
>not ila_map found with user provided parameters. Then an empty netlink
>message will be sent and cause a WARNING like below.
>
>WARNING: CPU: 1 PID: 7709 at include/linux/skbuff.h:2524 __dev_queue_xmit+0x241b/0x3b60 net/core/dev.c:4171
>Modules linked in:
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>RIP: 0010:skb_assert_len include/linux/skbuff.h:2524 [inline]
>RIP: 0010:__dev_queue_xmit+0x241b/0x3b60 net/core/dev.c:4171
>RSP: 0018:ffffc9000f90f228 EFLAGS: 00010282
>RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>RDX: 0000000000040000 RSI: ffffffff816968a8 RDI: fffff52001f21e37
>RBP: ffff8881077f2d3a R08: 0000000000000005 R09: 0000000000000000
>R10: 0000000080000000 R11: 0000000000000000 R12: dffffc0000000000
>R13: 0000000000000000 R14: ffff8881077f2c90 R15: ffff8881077f2c80
>FS:  00007fb8be338700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 000000c00ca8a000 CR3: 0000000105e17000 CR4: 0000000000150ee0
>Call Trace:
> <TASK>
> dev_queue_xmit include/linux/netdevice.h:3008 [inline]
> __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
> __netlink_deliver_tap net/netlink/af_netlink.c:325 [inline]
> netlink_deliver_tap+0x9e4/0xc40 net/netlink/af_netlink.c:338
> __netlink_sendskb net/netlink/af_netlink.c:1263 [inline]
> netlink_sendskb net/netlink/af_netlink.c:1272 [inline]
> netlink_unicast+0x6ac/0x7f0 net/netlink/af_netlink.c:1360
> nlmsg_unicast include/net/netlink.h:1067 [inline]
> genlmsg_unicast include/net/genetlink.h:372 [inline]
> genlmsg_reply include/net/genetlink.h:382 [inline]
> ila_xlat_nl_cmd_get_mapping+0x589/0x950 net/ipv6/ila/ila_xlat.c:493
> genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:756
> genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
> genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:850
> netlink_rcv_skb+0x153/0x400 net/netlink/af_netlink.c:2540
> genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
> netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
> netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
> netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
> sock_sendmsg_nosec net/socket.c:714 [inline]
> sock_sendmsg+0xcf/0x120 net/socket.c:734
> ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
> ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
> __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>RIP: 0033:0x7fb8bd68f359
>Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007fb8be338168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>RAX: ffffffffffffffda RBX: 00007fb8bd7bbf80 RCX: 00007fb8bd68f359
>RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
>RBP: 00007fb8bd6da498 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 00007ffc22fb52af R14: 00007fb8be338300 R15: 0000000000022000
>
>Do nullptr check and assign -EINVAL ret if no ila_map found.
>
>Signed-off-by: Lin Ma <linma@zju.edu.cn>

You should aim -net tree and add appropriate Fixes tag here.

>---
> net/ipv6/ila/ila_xlat.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
>index 67e8c9440977..63b8fe1b8255 100644
>--- a/net/ipv6/ila/ila_xlat.c
>+++ b/net/ipv6/ila/ila_xlat.c
>@@ -483,6 +483,8 @@ int ila_xlat_nl_cmd_get_mapping(struct sk_buff *skb, struct genl_info *info)
> 				    info->snd_portid,
> 				    info->snd_seq, 0, msg,
> 				    info->genlhdr->cmd);
>+	} else {
>+		ret = -EINVAL;
> 	}
> 
> 	rcu_read_unlock();
>-- 
>2.34.1
>
>

