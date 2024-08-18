Return-Path: <linux-kernel+bounces-291078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9F955D00
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DC71C212BF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5919129E9C;
	Sun, 18 Aug 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="DyaFshe1"
Received: from sonic308-1.consmr.mail.bf2.yahoo.com (sonic308-1.consmr.mail.bf2.yahoo.com [74.6.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DBEEA5
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723991637; cv=none; b=R2SZEn1R7STVHjuY4L0/e9flRxRD509mEKHQlCaKnSVYIkQsl/UQiFuAqVdsZac+/F6IDm/S0usxl6ZH9+nbTv+2Zuxnr5rqix0bXdcARdY287mgdR/56ZLgOx5FUUNtQvV5PbDIAAjYwG0f4BwV+hDtzzwYv4PRMI6CYjmD6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723991637; c=relaxed/simple;
	bh=1XKHKIKjGC9XCnNOCvWtJBLm19n+uVOk/QkjeQU8wgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM7UqwACvaEvmkTKfuCWrsQWAy3mtGCkTEJe9Xr48tLc/MVwW0RgzijWkU8Cd4xobPE3iqPYzO0a6q2qFV3bI72UF6gGhKDxidqV10iYjguThXWlE5Sr1HGu77U9yuG7xGrvkcYBdUsFFLeNnB/r2SEgxupyuRNR0Pq31EZ6a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=DyaFshe1; arc=none smtp.client-ip=74.6.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1723991628; bh=+YK/ji/DlkcZ3TzV0aGb39CAz+3zulPxbMu8jUlGTNk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DyaFshe1wZhmX5Hh+gN7O0L4Ga4CjhGdw/rXLxKgart7LHd/dM91MF2iop5zCezOZK2P8GOjG4RhrZv+BUwwAJJBz/Vg6qFKM5vtp/t/6OOfSOsUyU2MmN1uJIwF6I1Y/dVqE7IrTEZoVgtOTO06euEtF0l1kXE47wU7zdq7BelT/pQZbTgQ3IIFK1i3uyeGeEx/sIhEM3w9ernIaRlWrNd9YPZ3ZorIDJVBWBoFeUwDinTqht8xkWGq7ZdOAydlvq9COCi8e+Zwc11fEuaFdxNAXH1SaqOFBXd1wrsjUFYmYGWdPl8ausNyFLu3qCpRZPiDvr+XV1TwF49xTEtoAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723991628; bh=GQX4w9ZM/zjW7X0lApx8MOg0OT9w8YgSIhxw3Z4+0o1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=i9rKIiZpwuIkAlQiivN7zrq6zzKaGCTUEn+VL/DjGjRijcssBmRjyv5I/rgBojLA7DAS7YATGfyF1Xez0MrYwAQfk8vFVrJ1F3dwQvtHVS9vpMwdbNAh2O3DibhsktADkkdceAsOb6ox+ba6XADBhSprPztVcWcw8M6f1N29BfD6WraJjx/bWACSOiKUZj7sIk19jG25GnXqxh83lxJ7bjpQmsR5IqAMki+ldAZ6/tYiVH8whpfijtq2WfNahZ42eRZ9LbH4peKnlr1pn4B+RpFXhnmaHK776KwLidrKNiBQtmyyLB/Fo99VV5qIiHHpwFNJxzM3vc4g+PaQHLdEgw==
X-YMail-OSG: gY8g6e8VM1nV3e6UvECVm9oBGElEb6NwT1fNNpOpsAN8vn9lczRJ1jXIu5saW1J
 ssUQTKBhnSQqsm04gwlP.s.yVAYEdmf9VN8qva3rR9Hm2ctCjP7EWbaMbv7YPXwey2LxBMtBOHnG
 hDr1xu_yBIa6X_JWtovW6h5lduzMfV.MQjRtEIfJG8DL.m3Q.FgrzuEcpfkGfwQ_sXALC6oDCVxW
 TuJJzOQNl5zJNp3XKo2IsyFEawT0qP2CUCmSnS09oHXbEYGqQxx9vjtICvoWoIqcAzVJXvvLNWEA
 95EKAdEYa99vYCpWRcF0rLEAPdyIw1Ow4CV4jQB4nnKqoawUkOpj5lBZKJFDRiuL3xz9fLRC8qTs
 tKWFueZNbvzzey4nYWnCl.TqDeDINd2kLt2ztKpPSrvNPy7p_40.jV8Cy_zUonN3bxBSkOOaXHCq
 Gg.OUF.KQdJIz6Z4S7jnYMQdZUpmHawiHMDKeOmeyesbBmKIGkw75DBhuSMxxth76yKEQ7RfwJPB
 VXoHjSRlFgvLiQWwCnEiYqJI1GqqNucKETCExnK5Abl5XrwkfZyM3LdxVJTm0msWVKEGwkqB0apF
 x86TcARV5HeaBjZtjshoZZ8rA4CoK9FdatP1MsNLQPt3ERipUOMKZclKA3Hc1uLmMoZOKWVgtqAx
 g76ONC527ySc7SIqAHFty3yx4rS7QUVZskebBsSlo35HnEKZbhszB.PChSf8ZvYlbsLocsfvR_Qq
 bhKemhmPtrLMyLESPygXXFrQw0RD0bNq6ZT3hvUSoufobTiUQkS4VZuQbQcYTUVUCV6S9jpyY.t9
 J9iCXxhNGHGpNqtWf32bm0XM_BR4WSQrGDO5yl6Ao4Mp07T37mlqrIk2JTYDm8Ld4k5z_KYwXCZU
 SGSzaiTbGKRiabMTBC8MpM8WUNCKFSrBMg4KZ1U6msUMAbsvbh6dkZNOB.xy.4s4EjdAMO36zKNb
 BsAgFitDfFJrnQFfurn80uxXwPeVX5zUZBMVeDMUBNJ7DffiXBloRNm.X3b1j4g5A9HjHUJunHds
 5TTZ2Di0agOzecP3G27nDVKr52dPz.tPGP03T.eVJc_YB_7L63I4GHSJtjyIBSRvnaQJ342.aS.t
 KxZxm_e7h9CjknHa1KvZ_vN3OH5RTHZH_OkAABaFWCyM2dWW0DKJdi4MLWmO6PDsPpccu0mJ6kQt
 Sm0icwDMWVo6J..n2ECiJbLl8iMs.X6fdEdTRDkTJZ1ftLYX4VkC2DRzHItXpL0e19Qx8sIUBaLN
 tUhZZt0NP44gu.pYRJu_2Q63iDWs8nCxF23JjZLmI2flHdJi.BKdhKiwSW7V7G1Uph_OP6r1yBVf
 7MIysb7BSWAE_ikvXcOBiRuKXvUHqfvNwJU44G3qEb3u3jmUFzEI.JTcdfbD5L8cUuRvRkDsBFEl
 jMVF8kpTWhsyvAI5ydJvTQggXEWzlhY_XdUdIZh9EwlH_9KKgmxpZXl_ZyOapDhYhedDYLQiK1LY
 rW94gwrR69yvlmpOkeAfg9_U9gh4pas8nHw0i4vDkS7.5SFnjxeufYb2h0jpNaorYGhGvFuHnVQ.
 m3X7PqAsRiBfsKPintfSdeIeX8y6I8gQpyzYfTkV6hntaK8eGbBEsYkUd2kMwOjifoNAYlq3Fa9t
 GgHvP9lJNQSKnDVQz7ca5UHLYaUQtEoNxyJl7N8B4oDZvxB8HH5.b4v23OJLYDQnfpcYgxzacQ25
 BCmxsVClzFS91xdTAY_2Xg3do_Yg.Vp7dgtHCYBJMg6Cyn5dSHvtn78kK.bBAm93rQtXrTtCmAb1
 m_WsXJ7vJtp3LgXP2ynsCXapAJm_VWIXRrIiPwrNyfso.cOvleODCMoln2xKvU5NcG.Y6K9HgZdQ
 2ptWJCdWq_PpBCK0UeeWnn8S0Jog3K6hU6PoAdcoov_c__uCxJZMngpIDUYsYI5VjXcJr.gKeVzs
 Xm6qdLkRTlwqFdPU_mofm5aHB0KcKf1mhLwPk4sPILoYdnjj.ogHMIdhVue7NEcVJhjVUZtbTLqD
 8MmKDk0F2TaW9uGa.2eSAJPGCckhnp9WNK5syCrB1vUJEmiQTV9w4lDF3m4Kb1hgWrkXV6EYGMx6
 VeglFsq5rFIO8Oa6iakbIpB3IiXUTdYDfgANu0pLzURkiiu.omGdUFT5MQRB6Abanga22HnjJFwN
 rLRdgURia5CpZR.qjMcbZkiUBKsfheZIp_SrGB8zt0Qnqt_LYfA1.um01U0YrEVyf0xfe.tvCpUW
 JbMvwNALczAEU3L.i5PRDVg0XFypZLIrBGnoGzB4SvzATXuXcYlOfGTRN7BrK6_9oI5T.pgROiXL
 AF4A-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: 9e2345e2-b666-4e42-bda9-38c6c8da0730
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sun, 18 Aug 2024 14:33:48 +0000
Received: by hermes--production-bf1-774ddfff8-jvfvg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc21d25653818b99f5103f4d5b3f3aac;
          Sun, 18 Aug 2024 14:33:47 +0000 (UTC)
From: nerdopolis <bluescreen_avenger@verizon.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
 senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: VT-less kernels, and /dev/console on x86
Date: Sun, 18 Aug 2024 10:33:46 -0400
Message-ID: <6066116.alqRGMn8q6@nerdopolis2>
In-Reply-To: <2024081821-taps-briskly-c23f@gregkh>
References: <2669238.7s5MMGUR32.ref@nerdopolis2> <4805768.rnE6jSC6OK@nerdopolis2>
 <2024081821-taps-briskly-c23f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Sunday, August 18, 2024 1:12:58 AM EDT Greg KH wrote:
> On Sat, Aug 17, 2024 at 10:31:17PM -0400, nerdopolis wrote:
> > The thought is that when distributions eventually decide to go VT-less they are
> > not going to want to change the kernel boot options in the bootloader config to
> > force console=ttynull, and might want this to happen automatically.
> 
> If/when they want to do this, odds are a command line will be fine, or
> they will build in ttynull properly into their kernels.
> 
For new installs, I guess it would be fine, but for existing installs they
would have to script out the changes to /etc/default/grub, and/or however
systemd-boot handles default kernel command line arguments during the upgrade
process.

I couldn't get ttynull to be selected by default without the command line
without the console=ttynull, even when building it into the kernel (not as a
module) without the modification to printk.c
> thanks,
> 
> greg k-h
> 





