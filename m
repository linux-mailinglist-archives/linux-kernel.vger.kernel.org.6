Return-Path: <linux-kernel+bounces-413369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0879D1834
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531A12810F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462F1E0DF6;
	Mon, 18 Nov 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="LKt38qr4"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B651AA1E8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954789; cv=none; b=qQhmkmLfc1kYmBu1Y0/9kLKeO5BJmEsenLMdprtcqU0Xen8HiYNOhfB+QcM9ZtBWmvyJb1Xtxi5QQ65S3S3tFtyVn6zBD8O87a47WTyt7XxI4JtqSfI3pdljX8st7JYHEa/JhXij5lhJNrhkeJS0DjxErv43n+rqFozArE6/TVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954789; c=relaxed/simple;
	bh=vABaQHltdx3jgRYXQyVoHdcwpcwDsu4UKSsK+/mK9OY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jCOkcoPJlzBPNMHnT9Dg6dhkfrmNCssHd5zaDgfPEMeKkhPFGG82HrDSLvKrhjge5t8HL6Oq/pUK09tA7RKMuEm7jSZvCK0o8Y60OSTW7KONMxhC3B+oefh+ChVhKbtBSSrAWJo4ww6y+Wp0wqtA/VzRxJZ2GZQhtB/1cj+AWV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=LKt38qr4; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1731954781;
	bh=vABaQHltdx3jgRYXQyVoHdcwpcwDsu4UKSsK+/mK9OY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LKt38qr4UgPp504lHzG9BImmpehcu7oT4tlmhYqlIrjgeaS16zE5oubUp9SJSTdxA
	 F0f5ozNhlf2/3Vw90tz4ISLXJH3BlvzNFPiKqKAgOTVuuEQob/qIT7k8eQA458g9Ue
	 gaOSD1IXHyhCM3UQHmJ65BLWe2k/gV7y0yJfWaxI=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7BAB4401EF; Mon, 18 Nov 2024 10:33:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7A456401EB;
	Mon, 18 Nov 2024 10:33:01 -0800 (PST)
Date: Mon, 18 Nov 2024 10:33:01 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yang Shi <yang@os.amperecomputing.com>
cc: catalin.marinas@arm.com, will@kernel.org, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: cpufeature: workaround AmpereOne FEAT_BBM
 level 2
In-Reply-To: <20241118181711.962576-4-yang@os.amperecomputing.com>
Message-ID: <1a9c94ff-fad5-3440-705b-d8dc0c0b39b5@gentwo.org>
References: <20241118181711.962576-1-yang@os.amperecomputing.com> <20241118181711.962576-4-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Nov 2024, Yang Shi wrote:

> FEAT_BBM level 2 is not advertised on AmpereOne because of a bug when
> collapsing stage 2 mappings from smaller to larger translations.  That
> doesn't impact splitting stage 1 mappings (whether stage 2 is enabled or
> not), so workaround it by detecting CPUID.


Would be better to have a bblmv2_split_available() function that only
checks for the splitting capability.

If more code is added that uses the so far unused collapsing features
also included in the BBML2 feature set then that will break on AmpereOne.

bbml2_split_available() could call bbml2_available() and check the ampere
errata when false.

Should work fine for now.

Reviewed-by: Christoph Lameter <cl@linux.com>

