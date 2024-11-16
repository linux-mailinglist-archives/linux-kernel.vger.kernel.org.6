Return-Path: <linux-kernel+bounces-411601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD89CFCA5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 05:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCBF287EAC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12237190058;
	Sat, 16 Nov 2024 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YccUeGYZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124347DA62
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731729896; cv=none; b=KMOHcPcsLXLW/E4L9G8k/IXL9vLJeLoypG8nfriNyzxXGkpS6XhUpofGzUIgt5p5gK4GRpVxQWtEXxgK5AIIXpda4T1tsOQErfw3fo1sdgcUv4KfMraU+5bWnLbLuAUgcv2/dpWuO8K3TBGJA/w3DxYdkO2AreIwT7yCqCHqMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731729896; c=relaxed/simple;
	bh=UXqUZQxJJQbOYvIO4tCPTMd80dx0liFvEPAYeVDNHR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM4emJe+KpjO8+PoakxcpRo1GLqOpQdnUkcSWyyk+s84/KLlYq8gFNG/VNmcxJ4t/nQLmvWHuaigqtrzbBZF5KL/hR+A0qGTd2PvqDe286m+/ZmNQc7iI6BtpabDd55bNdo42DUQ0tkyET10VwWKFzRCJtARk3VrT0QjqwFBKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YccUeGYZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca388d242so1563425ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731729894; x=1732334694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/+zvJLSszxPTPcx6CDzWzGc29IlCznPJ3Jntw0Pz4A=;
        b=YccUeGYZqqXftuIELst9qPN2aHMhTWVTzWXao0btghfOq0nv4cj/Yo7oHFHKj9uFES
         86gnAVx4YWzYKTA048AWPM0Z63JqSvXHb2RCFmMgpKwgly2XemxG4EfGJWOkTgTHNWL7
         +6o6Z4ZinIPPpqOBQCgMLTAMfwlW69wzT6+dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731729894; x=1732334694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/+zvJLSszxPTPcx6CDzWzGc29IlCznPJ3Jntw0Pz4A=;
        b=VqkvOfDohTFpHkE5/7nHuosTZG8IJE0+L6GnyADx3pmhSd6NB5pFEVZxJS3otZQmGP
         DIkAZ1ruiNtrTRXsHEslDDm8RTyJ/xpMTnVIycc7I28rzn6bCAYRpail/j+AXddVMxDS
         uRFrwUhUtZXiprW8YEbFN+MpBQ0J1lpbvuv95ZlLAuomAEO5GXJb4FzwAbZC2E/X2Mj6
         5AXjLrJVuD6IG1i3G7jKW26WGof0v0xkdHEWWLHMwBtpmwy4PGqirxZ2aenvVWxnkQlJ
         lIjfuvUoIis2hw1Gt24V/R7R9uZezZm9bVa+8W8xTTEOHSjuVb0hTayPPAqx/OCtNQjp
         M6rg==
X-Forwarded-Encrypted: i=1; AJvYcCV4UMZvq+u9NT9bDQOaTVXGCLnI5fR8q5ZLAtaB3tV8257iyJunl4vOyO5ECz05OX8P5gPsr76Hz9p7L3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAxv7/5JRzeEEcDWj4vhKyhyHBAV4zBeK2A8FhBcwhKWHe6A+
	Xz5UXulLcuE8dS4oqkp8VPyqCh+gJ6DmsgkBQ2UjyT8B+Gd1HGkyY1zI7G4JkQ==
X-Google-Smtp-Source: AGHT+IHZK1G9tdxC6KPp3zQlMLXKqWEdBTvnKv8UpdzXfkJnpXftAR9nvrS4S+Qh4fkrjl0qq88Cng==
X-Received: by 2002:a17:902:dacd:b0:20c:a8cf:fa19 with SMTP id d9443c01a7336-211d0d72accmr80564985ad.22.1731729894486;
        Fri, 15 Nov 2024 20:04:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:142f:6cb4:e895:7127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7dadsm20016645ad.71.2024.11.15.20.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 20:04:54 -0800 (PST)
Date: Sat, 16 Nov 2024 13:04:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2 5.15] udf: Allocate name buffer in directory iterator
 on heap
Message-ID: <20241116040450.GN1458936@google.com>
References: <20241115060859.2453211-1-senozhatsky@chromium.org>
 <20241115120751.fnsvzo4453ab7hnt@quack3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115120751.fnsvzo4453ab7hnt@quack3>

On (24/11/15 13:07), Jan Kara wrote:
> On Fri 15-11-24 15:08:48, Sergey Senozhatsky wrote:
> > From: Jan Kara <jack@suse.cz>
> > 
> > [ Upstream commit 0aba4860b0d0216a1a300484ff536171894d49d8 ]
> > 
> > Currently we allocate name buffer in directory iterators (struct
> > udf_fileident_iter) on stack. These structures are relatively large
> > (some 360 bytes on 64-bit architectures). For udf_rename() which needs
> > to keep three of these structures in parallel the stack usage becomes
> > rather heavy - 1536 bytes in total. Allocate the name buffer in the
> > iterator from heap to avoid excessive stack usage.
> > 
> > Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > [ senozhatsky: explicitly include slab.h to address build
> >   failure reported by sashal@ ]
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Mauke beat you to this, Greg already queued up his patches :)

Story of my life :)

> [1] https://lore.kernel.org/all/20241114212657.306989-1-hauke@hauke-m.de

Awesome, thanks everyone!

