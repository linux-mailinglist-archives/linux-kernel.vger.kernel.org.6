Return-Path: <linux-kernel+bounces-285446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB8950D93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769A1B284CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAD1A4F39;
	Tue, 13 Aug 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b="am7s8RDE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA271A00F2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579573; cv=pass; b=P06mS9J2q9FveTYEfhsx5NicPWI/UAuZZxILAWpnBHe2ac5GAj044XfTUFVTYH7225Qv8u2/ZCujqBeTU+VE21lygJuWcoz4X7ur07norbWS1MuLZIqTll9nNvsq6ifyUWD1TajObll/WdExbjXB9jZCGJZ968C33xHLgjSFFxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579573; c=relaxed/simple;
	bh=1aNhFWk7kUadevvEHfpVPlJcGU717W4X8c3cStB0VFM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hUOWH/lleqfbng6XsZD3REiBNrdDU6QyrkHXZOlRDUXVZYxAbvsLk0XTdyV+ZAyBmNeVIW+ztNi2RDxrfVkCtyy6RnpPlGZ9xHlvC060h9z5KTrrUaThvnQnAtMpN0IW/v/FtncwrZ1y1POz2nF5AjDtmACQ32tNS7irZ4sRHtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=helen.koike@collabora.com header.b=am7s8RDE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: vignesh.raman@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723579567; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ONA+Dn/+VKgTnBa2REUHtNDBSRiJp/n5ZA2OUyvELanaiSdXYjUsm7WJPbnm5n2xNbr/ev9BaETrvr5xd5w8mL6WTi4kIS7+jNdRXMOLaHKBA1Fv0nu0C8GxXiQ0U4tqNnbVfeM12Io6ILYKjJaIteLYzfXgEUIJfNe+rV0HBe0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723579567; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4kgDpvw/qRDvAuTJMC6kdFG5fzn7p6L34o5jQat7XV0=; 
	b=mQbA50wIo226KWk/ovdaZ/IT122d5pDo8EnrcJ3eSGwaKsaFZltxD1EMXilZWDOzp7rtERBDTV18q9Kdmlf2mDZNsOJuLAFiNEFWvROwIHqzXsKbuE4gweqql/mSekrT2QyeGzgJRlu9k2dXl1FnbtrvnizuksI0g6TJ5XyPhJI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=helen.koike@collabora.com;
	dmarc=pass header.from=<helen.koike@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723579567;
	s=zohomail; d=collabora.com; i=helen.koike@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4kgDpvw/qRDvAuTJMC6kdFG5fzn7p6L34o5jQat7XV0=;
	b=am7s8RDE0ij43aAYMZsBpF6mFSYV/BJBBSxFR535LMdeGLI86cKT2NwomYru0Ve7
	V5B59hPlzvhaEQqbvCxhhA5YuKb9/h+AJyh3MBVCOFxWbcm8j0y80qA1CdoAg7Wn30s
	zEyulYl9TySqFrP+kBht0665Uvx2BrYMoQ8QNG44=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1723579566707428.10798840074915; Tue, 13 Aug 2024 13:06:06 -0700 (PDT)
Date: Tue, 13 Aug 2024 17:06:06 -0300
From: Helen Mae Koike Fornazier <helen.koike@collabora.com>
To: "Daniel Stone" <daniel@fooishbar.org>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"daniels" <daniels@collabora.com>, "airlied" <airlied@gmail.com>,
	"daniel" <daniel@ffwll.ch>, "robdclark" <robdclark@gmail.com>,
	"guilherme.gallo" <guilherme.gallo@collabora.com>,
	"sergi.blanch.torne" <sergi.blanch.torne@collabora.com>,
	"deborah.brouwer" <deborah.brouwer@collabora.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1914d590a61.110918b2f913118.3115650497780570443@collabora.com>
In-Reply-To: <CAPj87rNO4ckvgggn=FE4odpAsGDb95XZ7py0GrguJqB0Y0TN8g@mail.gmail.com>
References: <20240807082020.429434-1-vignesh.raman@collabora.com> <CAPj87rNO4ckvgggn=FE4odpAsGDb95XZ7py0GrguJqB0Y0TN8g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: uprev mesa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail





---- On Wed, 07 Aug 2024 09:33:10 -0300 Daniel Stone  wrote ---

 > On Wed, 7 Aug 2024 at 09:21, Vignesh Raman vignesh.raman@collabora.com> wrote: 
 > > Uprev mesa to adapt to the latest changes in mesa ci. 
 > > Project 'anholt/deqp-runner' was moved to 'mesa/deqp-runner'. 
 > > So update the link. 
 >  
 > Reviewed-by: Daniel Stone daniels@collabora.com> 
 > 

Applied to drm-misc-next

Thanks

