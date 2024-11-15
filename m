Return-Path: <linux-kernel+bounces-411001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEBB9CF36F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BC9B2F873
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2C1D47AD;
	Fri, 15 Nov 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kam0cvtl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8A166307;
	Fri, 15 Nov 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688294; cv=none; b=Ckln1IfUOtTTYEQjbJEhvEhR4M/sbGjjJC8/BUWOc9diLCDBWXja3ls/fIXNRGFbezDm18jNt4agW+zV92aT4e3yVTkdXzq/rg9njvthqV+LJIVwoLUF+IUBTA583Ez3JC1wVpZC6LHNzDORCn8E7bZK0ZCNDmmk1Mi03Gktnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688294; c=relaxed/simple;
	bh=DfXhHzNAUlPvC4I+zVZexoYU83C1CV6PWgQGq6jD4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+o8MJwd2FUqO/UVNuErfFFky08wrMKQYCq7Ken1IH8TkRiwniGRyKxR1t/+Kjivy7PIlN4p3fOtt/APZZC1R3ZtJqEhkFSig0YtcOuGy/sX9OXCb37L2KD9G2WB+U3mVdZpvLzUhMPdJEFp2n3ygcZ2V6IZwAmX8Z0Q6HQyadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kam0cvtl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1493470b3a.2;
        Fri, 15 Nov 2024 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688290; x=1732293090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luSUjsjJpOU906yg3ImSOWfSXGqxNYlf17e4NCxqtYA=;
        b=kam0cvtlBfsOXOew7VM6CQM5EyViLBpxrDZRtRzTGpM6OSuVhov1FU5f9AxfL9U1GU
         O0TsNYSz9hBjywy13E0o2RwHzaQVYZxZ+ymHG41oNLBQHwpU77zHAw/33vpWE+uHxisU
         dgUat1FXqRgGGpfhXdIhKOhqLPTBmz6LNMiDAsZB8m8HGdPDeTi1QV+3FWp1R0ZlURN8
         4lAC3Au2UsbPeNIJKeumrM28ypL2ldDhdNIggMB66yDsJBDOOGzYMb8MUaai40LPn/Ei
         bXgTxLfj0vg4+9UFo2++KF1309Xda0OEJuh5UD4oIeXgtxqIB4CnKVHRbzTDhpCYS2W1
         mCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688290; x=1732293090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=luSUjsjJpOU906yg3ImSOWfSXGqxNYlf17e4NCxqtYA=;
        b=KrluRCxVzkdMVITPOA4ysEBNTac2Sf7e2inaHbcrEZikr1FCDwxqIYVKjM5vHNURMP
         FWgJ9fyGf79u/KHFCHqt3g0kTYynQsU2lCM3jh16bho0oSHw7kSv9Zu26LN42eiCotZd
         aNYAUyRBZHyAs39LrunKB76zEvtjeGZLlNTaMoZtflcZ2rx3NLXrtMohMFMTjPVsrkVD
         oTFY164R8S+zEf5AyHQVQlzioFN6KtIrQj5YmgtkCYyd91UIfw3ENqBi4s4IRgqWKuSZ
         0XzFO/SO+SzGnB12iPOU1knffeGBkjl8XZM9OvnXK7UURhIzoSMgEoECP8ZXUzSGN4XA
         u47g==
X-Forwarded-Encrypted: i=1; AJvYcCXIAmof8J15tbX8+Y3DnlksAsvXooPfqzp54591Bi2BhU7n80R8lS6K7ob8X3MuIxlvURYZ7ENPdCgRMQ==@vger.kernel.org, AJvYcCXyvpg4vXDQL70nzbJkaemqtFh81uck6duaA1IqjV11QQHfT5H9iiruca7dsGWo/70LCuWe/7d6zj3m3sIT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91xOlsSRYyJjv33CpyNR7XAWid3lMyvZ5xM4ASX5UmzcCeiPI
	iFeLTD2RIdd5sHnB1WeqUzBEIU7cNdc89fKwbjtz9Vjods3q4vqIAijdfA==
X-Google-Smtp-Source: AGHT+IFOZdfyniMAavIRnD4eNgGDZlWkaAkqLOz7e8Xulr5D3cGVG5iQuKO+xlx/fl8Eg4Fwr2PGOA==
X-Received: by 2002:a05:6a00:1383:b0:720:75c2:7a92 with SMTP id d2e1a72fcca58-72476bbaa0amr3729067b3a.15.1731688288835;
        Fri, 15 Nov 2024 08:31:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247720121csm1572827b3a.185.2024.11.15.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:31:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 15 Nov 2024 08:31:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <20fde375-a88a-4279-a849-520063217de9@roeck-us.net>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>

Hi Thomas,

On Wed, Nov 13, 2024 at 05:39:16AM +0100, Thomas Weiﬂschuh wrote:
> Using an #ifdef in a C source files to have different definitions
> of the same symbol makes the code harder to read and understand.
> Furthermore it makes it harder to test compilation of the different
> branches.
> 
> Replace the ifdeffery with IS_ENABLED() which is just a normal
> conditional.
> The resulting binary is still the same as before as the compiler
> optimizes away all the unused code and definitions.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---

I decided to apply the patch despite my concerns about the lack
of dummy functions. Let's see if it blows up in our face; if so,
I'll revert it.

Thanks,
Guenter

