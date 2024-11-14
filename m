Return-Path: <linux-kernel+bounces-409339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B19C8BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB64B31716
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C0F1FAF0C;
	Thu, 14 Nov 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="Mv/RAIVA"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA3383A5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589862; cv=pass; b=XA4bB8DdZx/A/RT+SZFnJB4azue9YgDs7vVONu36w/PryMI/fOGCt6yhopcPmTDqYK8DeeNbdA8CA1G3uel5hxsH/Bq5Y/YbFJnBiMShAiY7+zcDnU6kEAXMlWnEfLV9ACHBeJitZz5abS6NV+wprA71boxl8hjPtwsHKlk8JGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589862; c=relaxed/simple;
	bh=OBJ7FsSPBCSllV/PAFc0yUDQ+HcT+kWurnsgeTHKbug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=q1P9pRGpv742J2AsZ8dYEx6wR2NrFmvtihZm1jJgBXvrFn7ENByDdLfB6ZCvFyQbllN71/dFv8dcdkmO6uU51+BEFsQa5quR6swO39U8EASFq5DEPrFFv0PurgDV7rRpuMd0czMbr1GpvuuRMZkSDUeCPKf9Tg1O/9N2oj89yU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=Mv/RAIVA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731589845; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k/f+pTC01kz6e9kpLAwUe16ixePuBxkStoUqmQDBQOYbRvhaMN+sZKKi/s9OuTAUqDCflU0U+Rn0AfhwOw6By2MlhUcavrI5YhtrbofSWTWFzyKIhWuUqZpN2VHz58Hnou38+HBe6bgESHTXJfGZQ/UfjA8H2ZcklAIS9lOZ2X0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731589845; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FSWhUoxAhdB6lSMDwjSVTKLi5Zip+jPlJqZckIZHULk=; 
	b=cQhBwp14IR1lzSWQ39Son/gacJp4fRMDpaDdowZQDSlvGl2elWwh659QJfrWbbIy+Lgww7/an4hr67depTsyOt+nx8Abvby2cKIG05wb5N4s6mkJwq8UwzjLzqIh70616oohmMbc9a2HA7UaFTFj4CXJM6XaWTGn31rXl0cy/L8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731589845;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FSWhUoxAhdB6lSMDwjSVTKLi5Zip+jPlJqZckIZHULk=;
	b=Mv/RAIVAnhD+zZ9lFK5Ms33Zg1em/70x4MmVVPM7iheG3kdqFyPKxkSgerrcp8fV
	2YE4ZsTVZkD6tiDuF0JeTd/3q8/1R+2czkJELKqp+JLXf/QV9xpD0n/R1URuXx/tKui
	7MRwV9Ji3MMDQeCPhm2c9efYAERQtWa2GpT47y9g=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731589813271173.51718259903373; Thu, 14 Nov 2024 05:10:13 -0800 (PST)
Date: Thu, 14 Nov 2024 13:10:13 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
	"Sagi Grimberg" <sagi@grimberg.me>, "kernel" <kernel@collabora.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1932acbb3d1.10d91b9c8590854.6159524670771006351@collabora.com>
In-Reply-To: <20241114055544.GA10948@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241113043151.GA20077@lst.de> <ZzTqgXqjN4UrT392@kbusch-mbp> <20241114055544.GA10948@lst.de>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
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






 ---- On Thu, 14 Nov 2024 05:55:44 +0000  Christoph Hellwig  wrote --- 
 > On Wed, Nov 13, 2024 at 11:05:53AM -0700, Keith Busch wrote:
 > > Well, he's doing what I suggested. I thought this was better because it
 > > puts the decision making in the initialization path instead of the IO
 > > path.
 > 
 > I guess it's fine in that regard.  It just usually expect patch
 > authors to at least reply to reviews..
 > 
apologies for not replying directly. I assumed a new patch would suffice.

