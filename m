Return-Path: <linux-kernel+bounces-310861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9177C96821F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE522836CC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AF18628F;
	Mon,  2 Sep 2024 08:36:55 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA12AE99
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266214; cv=none; b=FSGsFcey8h1SVmNWrtQAXSRM9lv0qM4kpx+3U1u+DqNUP/6+Z5uLnJe9ALDhi2HT6f1nFpWtPAibKokVhnOBPgwn0E6VnbAxKoFYiITVoj8LHUy7mak88h2gGwg/jQpXxRrBFXq/3bbIO6E1oKWij1vFCChMjrhZ1NhB+RVm4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266214; c=relaxed/simple;
	bh=SWejRdQp+kWHa8muEQd/bu49jIbL6oJzO8XqQMm46gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0dWOYOHsl50Dtg4HOQXYqY29a7QiBuMvObTFWUzWHmEDGfpCqPDpBqHkb5Kr7Y58nzpuRHEkUm06sFpeNUsKk14WgXOPCoSM1S3IJkzaHGRe8ZyiM/M49if6qVDKEpjDEvpBk12Ki9F8DlgeGpN9/7yTTRP07ZXgvg8GwBdB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1725266091tu2fqcr9
X-QQ-Originating-IP: kGypH4P7jg3wvqEFFYagyp6a6SZcS9GvI3fXkANzjYY=
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 02 Sep 2024 16:34:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11960807525001457609
Date: Mon, 2 Sep 2024 16:34:25 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "shenghui.qu@shingroup.cn" <shenghui.qu@shingroup.cn>,
	npiggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	mpe <mpe@ellerman.id.au>, "luming.yu" <luming.yu@gmail.com>,
	=?utf-8?B?5p2o5L2z6b6Z?= <jialong.yang@shingroup.cn>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] powerpc/debug: hook to user return notifier
 infrastructure
Message-ID: <DD7156ED36F34F8E+ZtV4kSBA-XH1f8NS@HX09040029.powercore.com.cn>
References: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
 <8734vzsw0q.fsf@kernel.org>
 <8734vyn1ky.fsf@mail.lhotse>
 <2acd6623-952b-4659-bc26-c632e94560a8@csgroup.eu>
 <0638f0a2-782b-411f-9937-c62d99e9562b@csgroup.eu>
 <tencent_4F2B3C0025D5A1722470D582@qq.com>
 <bd4908d2-cea9-406b-902f-618626e74c88@csgroup.eu>
 <B6A4506E3DD1F93F+Zs7Iq_EF799NyWHK@HX09040029.powercore.com.cn>
 <3fbdc957-2db4-4148-b325-263384f9a196@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fbdc957-2db4-4148-b325-263384f9a196@csgroup.eu>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

Wed, Aug 28, 2024 at 09:27:23AM +0200, Christophe Leroy wrote:
> 
> 
> Le 28/08/2024 à 08:50, Luming Yu a écrit :
> > On Wed, Aug 28, 2024 at 07:46:52AM +0200, Christophe Leroy wrote:
> > > Hi,
> > > 
> > > Le 28/08/2024 à 05:17, 虞陆铭 a écrit :
> > > > Hi,
> > > > 
> > > > it appears the little feature might require a little bit more work to find its value of the patch.
> > > > 
> > > > Using the following debug module ,  some debugging shows the TIF_USER_RETURN_NOTIFY
> > > > bit is propagated in __switch_to among tasks , but USER_RETURN_NOTIFY call back seems to
> > > > be dropped somewhere on somone who carries the bit return to user space.
> > > > side notes:
> > > > there is an issue that the module symbols is not appended to /sys/kernel/debug/tracing/available_filter_functions
this is not a problem as I just noticed that lib/Makefile carries this magic
ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)


