Return-Path: <linux-kernel+bounces-203107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D668FD68C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462D41C24FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E1152163;
	Wed,  5 Jun 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAEVk0jY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3F1514DD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615925; cv=none; b=bCMjud9ErVFgEQVNDYP/Rmc28nuVp5B9T6yWrz6Ke3R+OAOoOdF8MqfFwlQsT6tRVo52Gu0CZEmfVMuZ2wHFRXxAquOu+WNjT/lKbWSHZBgGLUdCoxFJpS/1WsNpItP2xHdyJYnx8nWZD1JaaVvE2QSJSo5G5ZKa4Qq8vgmuu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615925; c=relaxed/simple;
	bh=m0CXhwJL3QSo1uinEHiWUBm+QL6SC5BUk6YFU+VFrX4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRhwnXIiDkM0hd1SObxRdgYCa5slRXISCf/M72lt6gWS7V2bpx4iGgycxxUil2p5khtLMeoCzc/9JFXMeGr7oYHouqXznHpLRDywoTjlUL5tDdU4I7v+ODufsI9hHTYSWmJ//XRdnO0jBpGLYOAc6NsStC08Bjcu1cj6LkskMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAEVk0jY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717615922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wAUzjKjHQT48MT1CEnySduYKvPnHNLGmCrzOZbluMf0=;
	b=cAEVk0jYNoJqOMjrbH/HKeCSkr7Q9zjc+oLZ6/sff8cDSaF2ssJ33HOSiFlrogl0rIqDuL
	BKkccBPK7rqbNBhcwjEzZVeVYYHnKTAp2yXyd9ySNnOE7n4gS45yaoVYuq1H/IMM0pS8po
	/4Sn0eJVfiULRG/jEMHRvl4OGK4AfWQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Qpou7-NnPfqyYgOjImOU5A-1; Wed, 05 Jun 2024 15:31:58 -0400
X-MC-Unique: Qpou7-NnPfqyYgOjImOU5A-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b996b0270aso67205eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615917; x=1718220717;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAUzjKjHQT48MT1CEnySduYKvPnHNLGmCrzOZbluMf0=;
        b=bpIFAMS/ZV2BvJxGw6rEOxYTgG3JvhLiRfastErIjXOmkqKRtBB7jijOy8lfsDD/0x
         Hc5wnw0p0+Vm4XSoGqGgTDm1pJ44ywUjEvknTrT8HGIsFFdCKpwd1WdtSA9BXJdtpNFB
         glZmkD0b1ninoLuYC+jmccd4XT1E6mwWAijw1AX42gzuKLy1MV0BVyRFHPP7Q2oouGKK
         av9WOfzxq/mZC+UJF3noQXnsnm3KZ1uf6mtY5dVAMbDg9xylkN1cIJZSSoAv7oDgnLhl
         u4agRv1IhoFpyEUTCfziJovJA8PodLShzsHZVcBHJG0l5XAqA4qidi/PLvLqn3Sxid5y
         ePTg==
X-Forwarded-Encrypted: i=1; AJvYcCWLlp7TLASTBL8z8Ouc+V+e3yuaJwz7k4q0akvWhvMjhIdw9/9hPMLdpEaAZXrERACFbRR1ov5fbWB5jwRT4JheFLmZFftQvVjGqJZm
X-Gm-Message-State: AOJu0YzUH8x51+LLc9Z8mkuL68Jb683q4j/eTlyPx9TS1+Ap+ZiCwfh3
	o2LiaOcVBcmgr5PlVMTP9sPVwBwJIt9wNUyBWk0EA/schldIoRTIXEk1l3C4eHLtZJ5ackEo8Um
	k0eHFG/ITpTJpO3NKF351NTIfIbPVytg/WE19OMnQUHUB/c3U3LMGlOPjm1qxirVShoH6v+fOir
	ObPxjrE5NyEpaxXt+oINcUf3U+9A6311KSrYha
X-Received: by 2002:a05:6359:4103:b0:183:612d:44a1 with SMTP id e5c5f4694b2df-19c6ca19ed9mr443019755d.28.1717615917164;
        Wed, 05 Jun 2024 12:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzqeFCvtmsiZCw2U1K3HXxO/IPPSvtKOjW3/Ru2mn4jCUk47tlrWhigUB8CObse5CiTfalvEzZeA4Lp6TeH8=
X-Received: by 2002:a05:6359:4103:b0:183:612d:44a1 with SMTP id
 e5c5f4694b2df-19c6ca19ed9mr443017355d.28.1717615916756; Wed, 05 Jun 2024
 12:31:56 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jun 2024 19:31:55 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-6-amorenoz@redhat.com> <202406050852.hDtfskO0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202406050852.hDtfskO0-lkp@intel.com>
Date: Wed, 5 Jun 2024 19:31:55 +0000
Message-ID: <CAG=2xmOQBaUki43jpUnP7F-RvkxXroQ46_CuXvbQyps=MvvYAg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:29:22AM GMT, kernel test robot wrote:
> Hi Adrian,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240603185647.2310748-6-amorenoz%40redhat.com
> patch subject: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
> config: s390-randconfig-002-20240605 (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406050852.hDtfskO0-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    s390x-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
> >> actions.c:(.text+0x1d5c): undefined reference to `psample_sample_packet'
>

Thanks robot!

OK, I think I know what's wrong. There is an optional dependency with
PSAMPLE. Openvswitch module does compile without PSAMPLE but there is a
link error if OPENVSWITCH=y and PSAMPLE=m.

Looking into how to express this in the Kconfig, I'm planning to add the
following to the next version of the series.

diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 29a7081858cd..2535f3f9f462 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -10,6 +10,7 @@ config OPENVSWITCH
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
 				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
+	depends on PSAMPLE || !PSAMPLE
 	select LIBCRC32C
 	select MPLS
 	select NET_MPLS_GSO


