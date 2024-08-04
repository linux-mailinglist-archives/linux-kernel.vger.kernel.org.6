Return-Path: <linux-kernel+bounces-273674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE2946C10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 05:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4ED1F21B51
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F11D6FCC;
	Sun,  4 Aug 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b="d5+SdxBX";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XYj6CdZG"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CF33D8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722742655; cv=none; b=s4OWzbSR54Ja1Wz4Gj4gXodirnUK4oaf/KltyHtgqsRRSUABSgKwx7w6F/83jl+grK1ri7hRhLXSAQ2EZd6208DIENW+UG3JcTLj7ZDEPecEp8nlVH7aYAsgkcf6MSMhQ6zaVfgxy8IQ19NMJ2safJ+yNbw7eDqXJvSe171J+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722742655; c=relaxed/simple;
	bh=uo+W6zhruj+fAbuki18eIyyi3TPrz4wMW54vLFJ7HAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XW5tbHm2uQz6v5PitY0IurECbyKQs2v4YubBD6nXVReV4frBT9Dz6vUYlh8NDme268UHXWTI8WImHH1xr2iA2z9LB0MeVSPWXUCJ8YHPQnrQxv5/4H7i5zdlEij9TeqcRgctsGz5pCCMgwXCrZFIHFeyu12G1Q7dih0BcFxDQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name; spf=pass smtp.mailfrom=spwhitton.name; dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b=d5+SdxBX; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XYj6CdZG; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spwhitton.name
DKIM-Signature: a=rsa-sha256; b=d5+SdxBXj7+cB0EZOizg5zXIHTfqxgsW+sVbVaSgh6MySV+cF6I+jCpIj9lLuFg22etxcKngPbn43llYhnKywmdYvvwQvyNA4gfSWsLnIzkB9FNnviPt59/6spkrVrDcQWaHlBI749AygyTnuRp/FuVY0UHedGCfIMEbTqmgoareEKoLGcpvjskM/TBdy2jqrwPYyL2nmZj7+z/xI1w3ZKHwAFI4H4R7ALw17MzmSzd2Kb8bg/Zhk3eHHDH4zcR8h6nILSmJTSKOA6czJoWDr07wRXZ9UfgmssJ+sgsgwThITT8VQRg92UMKgXTUC1wD1p50mq8XR3hYIUqConP7Ug==; s=purelymail2; d=spwhitton.name; v=1; bh=uo+W6zhruj+fAbuki18eIyyi3TPrz4wMW54vLFJ7HAY=; h=Received:Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XYj6CdZGYWLq6JhxmwdX5LDoMKxsa2TxdT+iLcWgY3o8LRyah0QTNpfcqYJWq/QvYpdbaT+xXBTQ0kauir09c3LgRjkxKvvs04H3pWfBTjjV803gfRFc0Vcmx2SEnAidstcZ+yJoR3x/nMG/PzUl/4a2bK4MFFc/QEIuW8XkcjDoVOnyEmLJnr72QtkSZY5oiYRlaeOn7pfS6W+LzeIzCo0wHUIEEdb4FfNFIKV2qMkWBw3/jSzvc0Fug2TxwUfkvcl7KFCpZOhTeXdovoMWj5XYD57YfNZpO3jmIr//xBLstrzWebgKo/u+9oSTQ3VRBB+88t6obkwUMNWEw64BJA==; s=purelymail2; d=purelymail.com; v=1; bh=uo+W6zhruj+fAbuki18eIyyi3TPrz4wMW54vLFJ7HAY=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 20115:3760:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 694657548;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 Aug 2024 03:36:47 +0000 (UTC)
Received: by melete.silentflame.com (Postfix, from userid 1000)
	id C17037E4493; Sun,  4 Aug 2024 12:36:43 +0900 (KST)
From: Sean Whitton <spwhitton@spwhitton.name>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  ~lkcamp/patches@lists.sr.ht,  helen.koike@collabora.com,  Hans de Goede
 <hdegoede@redhat.com>,  Mauro Carvalho Chehab <mchehab@kernel.org>,
  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-media@vger.kernel.org,  linux-staging@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: Add parentheses around macro
 definitions
In-Reply-To: <cf999a28-7227-4ee9-bc5f-9fe8c370458c@suswa.mountain> (Dan
	Carpenter's message of "Sat, 3 Aug 2024 01:10:58 -0500")
References: <20240730062348.46205-2-spwhitton@spwhitton.name>
	<2024073020-reload-vanquish-f937@gregkh>
	<87v80i475p.fsf@melete.silentflame.com>
	<8d383b9d-d029-4706-91c5-9623fddf5df3@suswa.mountain>
	<878qxe41c8.fsf@melete.silentflame.com>
	<cf999a28-7227-4ee9-bc5f-9fe8c370458c@suswa.mountain>
Date: Sun, 04 Aug 2024 11:36:43 +0800
Message-ID: <87wmkx2c38.fsf@melete.silentflame.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

Thanks for the additional pointers.  I'll dig into this soon.

-- 
Sean Whitton

