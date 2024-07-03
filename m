Return-Path: <linux-kernel+bounces-239970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E3926764
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBED1C22E52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAE18509A;
	Wed,  3 Jul 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W8/vxQRy";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="rph9gUe1"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A071C68D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028836; cv=none; b=ClCPuhHYLjeyjoHuzsEmrZ/N98do1EyDJedKDVTRTUkxwV+03VzqDY6wNL57Pjt/3cM1hDUgt9XZ/r+ofIFaLf8UvZJr0HVO6HwGrt4MlbZacyg+b1Egu6+I3EAAj8LxdKGeF6zuASrCpPrT3/0Ewka8oyhfdWBrjSNSdpWfRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028836; c=relaxed/simple;
	bh=1OP7oD0MYlGpUSHVkGMiEc/aaQyhmSsxyzlIOGxDBeg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=au5eeA9RLZAnk8dwviOmn04Tgv5GWESD354JBAeSy9tIT7R3Lo+tdmzQa1/+iz4HWkNgA7bEyIxZHi9S83JHmVYxxAE7JjylFkSEDqy0RcEDQAabWZQSJCNCDA5ly86I3ZcdjBVpSXG7FnWYF3hMFcF6Gkorm5naS1jgmyqnxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W8/vxQRy; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=rph9gUe1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4D702B7CB;
	Wed,  3 Jul 2024 13:47:12 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=1OP7oD0MYlGpUSHVkGMiEc/aaQyhmSsxyzlIOG
	xDBeg=; b=W8/vxQRyV/y3HFvdlO3ktGiQiG2YfPfXZfI5GRPLHcLfgdy2r8Nlpz
	WYjPmFIyRotzB/89i1wf9M2yG8NG6h6hkqQK8Fq7ZZMi9OwPoafZkTj7GbFbTwlW
	G/WApze9wa1J3D2afB2mzlAdmORlZVcw/c6njDFafIy42bNu3nJ+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC56F2B7CA;
	Wed,  3 Jul 2024 13:47:12 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=1OP7oD0MYlGpUSHVkGMiEc/aaQyhmSsxyzlIOGxDBeg=; b=rph9gUe10opNZccRphBJ1MF3srMViR5iOuz117UOn9ueOJxbm0BoFNb2OVi1qrQpKFInw/BdXpzueju02un+GqfSIOWOaWb4N8UAb123Pg3cjDUQyzB9elypp+PC8RBjzggqgFBiR1aCD+fmVhkRmGrfqv2ldEqJDwuI2p+2yXo=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1269D2B7C9;
	Wed,  3 Jul 2024 13:47:12 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 007A3D324C0;
	Wed,  3 Jul 2024 13:47:11 -0400 (EDT)
Date: Wed, 3 Jul 2024 13:47:10 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Andrew Morton <akpm@linux-foundation.org>
cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
In-Reply-To: <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
Message-ID: <n92q9p5r-9o9r-prp3-s256-110322s5n233@syhkavp.arg>
References: <20240703033552.906852-1-nico@fluxnic.net> <20240703033552.906852-3-nico@fluxnic.net> <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 46E89FB6-3964-11EF-B387-5B6DE52EC81B-78420484!pb-smtp1.pobox.com

On Wed, 3 Jul 2024, Andrew Morton wrote:

> On Tue,  2 Jul 2024 23:34:09 -0400 Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > Verify that edge cases produce proper results, and some more.
> 
> Awesome, thanks.
> 
> Do you know of any situations in which the present implementation
> causes issues?

Uwe could probably elaborate further, but the example given in the 
first commit log is causing trouble for a driver he's working on.


Nicolas

