Return-Path: <linux-kernel+bounces-285107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A595096D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873221F22341
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725D1A0724;
	Tue, 13 Aug 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMEgEgY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F012AF0D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564263; cv=none; b=POheCLhauutNq1qQSvJLBa/L6meXbx7HP+mglmIyqwK6I8ksAZKNafSlQVjEAQZPd1NjN2+WVgOibwQHyTWoWZpRgjq8n0LCmNLZ+beYGPW/R6Hucza90B3b+qUtfKsru9PTMHkAiB+OZa7/jRSZtBtuFqfzWqGKu8Uamktbi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564263; c=relaxed/simple;
	bh=ghzyl8uuwr0XvjnA/rJOQpvam9nTnJ/aGrKOjj8KZqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P06mFiO6HXwpRhWyL10gn2qhl+bUFLjdhBcgcvhcl7uSuxeW2aSAscps9RbfSkn3OvvKmJ5peZc9ZBogPR7HBgobh0VPDuS2AMw1E/9Ybzy58Z5U6/wQsiI9Rjqf36/+rWqt59m66Un/W6dIoA7zNdHqvUGglTJlpqnGhf36d2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMEgEgY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F10CC4AF0B;
	Tue, 13 Aug 2024 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723564262;
	bh=ghzyl8uuwr0XvjnA/rJOQpvam9nTnJ/aGrKOjj8KZqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMEgEgY/5bgCSwAM2vbxb/DRlIaj4N1Mh8p0w4Wksw3QSwvLn2ZBZNeYA0KDhn1YM
	 pwk1U3DPkObQkyiX3ZzXp4AvgX+UcuZWtFCMTFAjtMqhvoydGwoG917w6cYtq9rySi
	 TUvbLOgfTucXVOlyy13eY7BrH/ARXZ8sEm4caBCs=
Date: Tue, 13 Aug 2024 11:50:53 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: Simplify driver API
 device_find_child_by_name() implementation
Message-ID: <20240813-mysterious-meerkat-of-gaiety-28dee9@lemur>
References: <20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com>
 <2024081330-posting-tapestry-9372@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024081330-posting-tapestry-9372@gregkh>

On Tue, Aug 13, 2024 at 11:41:50AM GMT, Greg Kroah-Hartman wrote:
> > prerequisite-patch-id: f58374cebf0ada070fc0825736424dd177e49676
> 
> As those ids are not going to be in my tree (or anyone else's), how are
> we supposed to apply this?

Greg, these are patch-ids, not commit ID's -- b4 will pull them in
automatically from lore and apply on top of the base-commit specified before
applying the series.

Regards,
-K

