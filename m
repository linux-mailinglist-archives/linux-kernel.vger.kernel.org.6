Return-Path: <linux-kernel+bounces-298650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55C95C9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18FC1F23399
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03B1514E4;
	Fri, 23 Aug 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THLf8fi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04655FBBA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407151; cv=none; b=Z4dCW907p3iEZeD8INnoGHXOFRo/z2pEYLdL9Y4vf1Cs/AeWwctUnHINqa/lX+381gqW6AHStbSGzvFqIzFhZmKCh09Wr2grXGdyD9lMZoOjYRSm7R8r4BoWW6Crkj+pQxkU+o8V+o4964Ms7/iPHXNPrzd8E/93tcew6auE3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407151; c=relaxed/simple;
	bh=Tg8xKnNk1G0kif4YdIQaPG+lByeECszbe/W64rw9AMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaN8GwztgdqkDlpXwUHTMLH0BZua96EpdfA7KutYgdCWQCgNAWUcmPHT3b+KM4gmsBxsjBNqA+EAA2y+59Dw7goHum5595Zuh4QmD0W2ktRhnd8aWR703TrvCJAPLnEDaFChP8whBVrkwjh0G4gjioMn3MXoaIHKPXeRPxjt6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THLf8fi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F5BC32786;
	Fri, 23 Aug 2024 09:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724407151;
	bh=Tg8xKnNk1G0kif4YdIQaPG+lByeECszbe/W64rw9AMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THLf8fi2tZT0pEf79CvLvQxXYMJD8vZhgK70loOMOzS2Qv2e8sHz+FH36lb4j/XEt
	 j1M7ZSbry+yjSP7zELycDkNxxTwFrcg71+vcXd0qDqlmoVp25Vg819uFn+Fydyerdc
	 Tzxr02QTA/JjE4w0sO5i9G7eiyTrB5f4Ez9G4LAuUlaYndTDdf1PGOcnnZ2IWwPQ+6
	 9P/xgoztA+APtWd321NZaPsTi2/cIeVPnFNHkFZMlEViD80n1seErHOKiz2KIaioFz
	 ubtWdxd7lQtGMFo0frNeffCzEXsNgtinqafWhNclgf2q12tiRCXpySYEIazxgqxzC9
	 1LgU+T/qIMaVQ==
Date: Fri, 23 Aug 2024 10:59:06 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	anshuman.khandual@arm.com, david@redhat.com,
	scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Message-ID: <20240823095905.GA31592@willie-the-truck>
References: <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
 <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
 <Zo2C4eXr5_9kifyO@arm.com>
 <cb0bd817-6948-4944-ab09-4ec2aba41cfa@os.amperecomputing.com>
 <Zo5S1JE8B912SHya@arm.com>
 <6167c4ce-fef0-4af4-a6a1-9fe7b2eb023d@os.amperecomputing.com>
 <ZpAZ39VQhxfNepWT@arm.com>
 <cf0777ce-52ed-46e4-b666-50a04d5025e0@os.amperecomputing.com>
 <ZsW_AtR-X_CqCMOW@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsW_AtR-X_CqCMOW@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 21, 2024 at 11:18:42AM +0100, Catalin Marinas wrote:
> My view (as kernel maintainer) is that there aren't strong enough
> arguments for merging this patch. It does show an improvement in
> specific cases but the downside is the risk of affecting other cases
> (plus additional maintenance cost, though I'd expect the opcode checking
> to remain the same). I do think the architecture should be changed so
> that the kernel gets the right information in the fault handler but it
> would be a while before such feature appears in hardware.

I agree. This patch is a kludge to work around a bad assumption in OpenJDK
which can be (has been?) easily fixed in userspace.

Will

