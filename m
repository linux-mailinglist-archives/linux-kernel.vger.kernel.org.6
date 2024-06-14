Return-Path: <linux-kernel+bounces-214926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B0908C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF931C22225
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E636E19A2A9;
	Fri, 14 Jun 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmr5l/oX"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EA26ACA;
	Fri, 14 Jun 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718370507; cv=none; b=PAomQ9/Gz5p3qT5caj91gDXCPnmwHKcdZMdE7G+QHZlswZPC06KijMw8lTle8iv7mNC7R0e6SAO9GfaJcJYts/6w9EUa4EFQbltPu7YSUAwvi6o3aU17ZVIBer0AHaA6BCkOOofQcN/EwYnSVb2B8ifAkxhXoDJYVTrnTiu2TUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718370507; c=relaxed/simple;
	bh=t3xhUUAwCao5G4aVc1jzhrPvysAENUJFdWQNZrkQEnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGN7GsHiOcGuJNb8gy3aNcxsB9fEj1yXRLuoq4FFpJEPG2b9iy8Qjk7rhI9DRR0WH24npUmLXIJubnyThM4JNuOR5JGsULfgXLz7onms5ooVoERWz3aQ5I8P2Vn5RwJazex/5BEKdpZSwFHx2s6xlUPkmpc9ZlQuBeIRXQUaquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmr5l/oX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso1288452a12.0;
        Fri, 14 Jun 2024 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718370505; x=1718975305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNM2KHSPHrZv0rqrC428DTKu5CzRUqPsIONnWWtEu/U=;
        b=Xmr5l/oXr2F2Kvh93o0fmBxWptWeaQqRy/Nz7yPBguoc9EA9mZFSaJfgmi4Ui3blA1
         QR48ZceRtYOE2pr4Vv1HQNWgTEeIeV+UAjGxiEwDKNA5L6APcSPSK2xQ3KIwpP7vC2Aq
         /tmHW6QdmSrpicC0zfJN6t3pPvUNTxxXmtiutqa25RF9zYDMTsvCxa5bs3BSbZGUyfm/
         +T0SwfzmrDgbeadnzEDu2JaqF7Fs3AwbBnPS5rFFwpQRLo1AfQaBxGY73y4zdtiZTtOB
         C+QyS51N3Q/Ey2dbMEvH/VGIHF0RDa7tlXDIj0lVhK889Bi7BLl0T0sKH2vrZhKWcfu+
         WDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718370505; x=1718975305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNM2KHSPHrZv0rqrC428DTKu5CzRUqPsIONnWWtEu/U=;
        b=euO/yLI73e4bCH9Za0hurjW6fR74VO/U1UK2jb12skXY/aH7+Trw4r7HY99sh3H9/2
         i0Qx6kpmKOwHFefBOxqLtBBWDOdm7XW6CJ1bkZOEmV8vM/ZzfZrWxRkontxp9cTdMhkD
         5JaMBRY8FjkmTFacwDZYyk9Cpx0DuFK7xoRxN1YZR+CDhQJgTuHagqk6RNOpThWhe7+r
         /OBiKgPv8Uqc06ZBXsQVimXZQQX8o8RxAum95Z8qNcAnKRk3KFDklMVlI030OQES3grv
         yvo4RdU72fQ1D85LXB5VXtpB0eWYCczT9YDM6vlB5RhSY1W2eDfpmaYrfnNiy2sXLBH4
         JmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+B/FUnkF8H8stEp9lwihlMB9Gw84SuxjYbQcIBuXowVpX/dRBMWkQMdD8qb4e3YJjZZPKgxNnnHyQhaFAGgogLj+2/hSogHldt3F6VoAZD7wqcNzL6eGZ0iS8E7knuf7c8DnJnpTGRfk=
X-Gm-Message-State: AOJu0Yz0Hoqy5hezv+okFvAndGazxmb33ni8R5L5m6888KGlLK3CxFrV
	UiMH2mHlXMuLDXUYbMz1sFfrLK+rML7cGd0mOvulipbOmgDHR1YB
X-Google-Smtp-Source: AGHT+IFGG4IyXXqa6zyUtivb6vcFgZtJ/33V4QOuxQ5yb5USvZK7qpPWNOzs6HK8SBxmFYDL7Iwm/Q==
X-Received: by 2002:a17:90b:705:b0:2bd:d42a:e071 with SMTP id 98e67ed59e1d1-2c4db951d76mr2408414a91.30.1718370504403;
        Fri, 14 Jun 2024 06:08:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a76a9a42sm6084845a91.49.2024.06.14.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:08:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 14 Jun 2024 06:08:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] hwmon: (max6639) : Update hwmon init using info
 structure
Message-ID: <2b53fe36-ce84-4237-a53d-fae35bcde705@roeck-us.net>
References: <20240614055533.2735210-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614055533.2735210-1-naresh.solanki@9elements.com>

On Fri, Jun 14, 2024 at 11:25:30AM +0530, Naresh Solanki wrote:
> Update hwmon init with info instead of group. The hwmon info structure
> in more flexible to describe sensor attribute & easy to maintian.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Applied.

Thanks,
Guenter

