Return-Path: <linux-kernel+bounces-394490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F3C9BAFE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9952844D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581761AF0C3;
	Mon,  4 Nov 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnxJp7Vw"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABB1AD3E5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713033; cv=none; b=fQ3tx91ulie5apcfvtmViYLEbOzPaIELagSnKwif6X3xjh3C3R6iCJ4bGbHPWtpaGXPHaFEWlYzxXwFyg5+5Jn3B977lwL/A/wQrOpWgspFueq5edDcefdySTz73mLAwOzuaiDqGiudMT6CSDVESGRH/B130N9a8ij/rks0JwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713033; c=relaxed/simple;
	bh=MY2rp5wf6E2LUHJUI8h5/NxVKPVn0Iy4zoc6RkSVuFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl+2syn0/4aVsTFTRrk+qJvI/XCksZ2QK2LrdxnCg+w/1LqL1nKS53od2xcTQJu9nh2m9MErxLfQaWgtEUKNQGuQr8WddlMlwimdXLA8IAhJVLHaRyhGQRIt2FQdFHa0dWs/RWCu6gXl1C6pt1egfsb4/3g1SjmuQWgxg9/gKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lnxJp7Vw; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a4c303206eso13669995ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730713031; x=1731317831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MY2rp5wf6E2LUHJUI8h5/NxVKPVn0Iy4zoc6RkSVuFY=;
        b=lnxJp7VwM9jDEfzr3DUrtzz+O+B6cMblprIEcVKwvq8pkMIy+m5su5Y0jTfYaAVUN6
         LQQ/FZsRUp6NZFyBH1pUg03rfL4SPu+p1qLCBEuy/by6TleHMNZGCR7CLUc6WuuvW/lS
         4BIL1NgNn8ODPZqNOj0AzpkK6At7dEeH59Eek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730713031; x=1731317831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY2rp5wf6E2LUHJUI8h5/NxVKPVn0Iy4zoc6RkSVuFY=;
        b=FqTFbl42OO7qXiSKZ9XsHxe5iS6Azdd0IxuO/nfVQt3lChVRM+SmviglAAZ222FsSE
         vrwa84oOfxq5XmT3kIxZ/X04HObFjOpyGnuSexNZAFRRRivs+EB9r6lco2Estx39NiPN
         BBizg6MFchtxlD2SHmx5BCz3j6hihTKhb5QriBKcC7p9/gA5LIIRVLx72o4/pg+ngWVX
         9etY6RyEley0ODvceZZc3l4qpee8WD1zuGPFjoDXgBNDgzDoje3RROWUyq9AgOTaop5F
         XncWet8xv76s6uWW8iByF4FFTdzDExVpfC8D+TswqavywQ16VB8cYoldwaaUV7o8lci5
         ze6g==
X-Forwarded-Encrypted: i=1; AJvYcCX4nswChCGYdwvIbdyPRH/W+lTBjWZiNrDO8oAlXNXAwpq6AWW1tdPy6csQTr/n3H7QoMme0Wy2VY27kBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmXjDci8usUm20gXpDxg7iG1Nfa4S//7QjNX2P96gpYKSHJWq
	Yc+FC4M+J/8PxIRCCcqF8hByOa4W7opEoYlfdcZvZFfxtYxK9emmKTgikLUtVA==
X-Google-Smtp-Source: AGHT+IERx/ADYceC5a5zEW46lzEnv9iehhOj9le11sO2FUtOBDhxbYmf3z6VBPm+cA5IV1030jkBEg==
X-Received: by 2002:a05:6e02:1a6c:b0:3a5:e532:799d with SMTP id e9e14a558f8ab-3a6b0289030mr103184335ab.3.1730713031299;
        Mon, 04 Nov 2024 01:37:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:313d:96c4:721d:a03b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f8ee9sm6625347a12.72.2024.11.04.01.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:37:10 -0800 (PST)
Date: Mon, 4 Nov 2024 18:37:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 6/7] media: uvcvideo: Use MEDIA_ENT_F_GPIO for the GPIO
 entity
Message-ID: <20241104093706.GY1279924@google.com>
References: <20241031-uvc-subdev-v1-0-a68331cedd72@chromium.org>
 <20241031-uvc-subdev-v1-6-a68331cedd72@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-uvc-subdev-v1-6-a68331cedd72@chromium.org>

On (24/10/31 13:43), Ricardo Ribalda wrote:
> Right now we are setting the entity type to unknown for the privacy GPIO
> entity. Which results in the following error in dmesg.
> uvcvideo 3-6:1.0: Entity type for entity GPIO was not initialized!

Should this be squashed with the previous patch?

