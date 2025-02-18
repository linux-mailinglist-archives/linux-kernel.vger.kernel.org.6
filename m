Return-Path: <linux-kernel+bounces-519321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6DA39B87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7617F174C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7624111C;
	Tue, 18 Feb 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDnhoo6m"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876C241111
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879814; cv=none; b=IVAo214ffZ7FTpah/YQSzuRbTuGt1MBuVYHutQsT+QSh0MltO3Ihwg23tdVXEp1GFDFdvlKB3ZcQFprPa96ChQueImK6i6JWNVOusX3rSB8GIwCAi4+aNYFAajJttkXsMa9x2PQXx5X73Mvlz/c1Ml0qsFEH6cnac2J89xLBFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879814; c=relaxed/simple;
	bh=YSuUZpQwyI1ReUjchWfaRa5IbfoeOSrqhxxtaNLXXTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiLyvDZu01vXu59MsX7H+pXCoUpg5nirakv+Jn/ZB8RDaBtohzKUzCtfYre5Jh80BBg9gw0unE/61qTy7igjZKLREq7PVYofaUV0Bcr1yrJ3SMc1gHqyb1Dv+v1BDmcpbVdv8Rhu5uTWl4A1fNj9HfcAxJHlVboMb8VxMWMsbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDnhoo6m; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2210d92292eso73402975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 03:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739879813; x=1740484613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEcQ5QKcDeRXJqSlbMneaKm0YQCQPfq9RtB35jSUmKw=;
        b=QDnhoo6mTQ3MoxmmWulS4jV8gfySfYk9/wUbqz1l9nId3RQl6pyeAyJdjOBpgEeHVB
         k+i0NMC66odoDxXuYo0dA+FKTgC3Dmoo9BlshSIJ+zmQ6Shj9mAwHBheRK2u7NlgZGd3
         HRa6kjOnwWIFWO3/0hhihzZsBySc4HHqjxDrfnGUhEzjV3lD7HhzCubCTpo141dc8YNZ
         ApDs7MxsCi7PK/XbV/bkrsJRpaC0BcKWPM+9B6bFeHZUvlQwq4VzCjNt2MIMGvvu/71H
         mpMf5AqjoW/up0wRGH93iu3sy9IY+8jszcaLi5+sTi6Z41JVGhBUCZK8e25ZqVL85gl6
         6i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739879813; x=1740484613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEcQ5QKcDeRXJqSlbMneaKm0YQCQPfq9RtB35jSUmKw=;
        b=dnIo22uZr2gAhHlT/Not6teYgRdv2i/xdovAPGJ8NFJJGKmWY7IXTLTHo8UNnzSt6U
         m+rnWtIGJjc7Y0jPyDMYny9sap0/GVw/xcxP21ga2VqKuP664G2kwCBkpLX6Rp1kSE8c
         JBMadc5Smi/GssbmNpu2Ts+OHpl8dz5km39+Vb4DUa/OpgjJEY4H2yK719MPwJMGnOdL
         s4nCMOXpX5cRD2nYAOhFN34UXRXpC4/yi8sfvEya1FlgAe88BVv6hzscjBLjPY65lqMn
         cOHXhPzs48l92EEVFL1uCYDXdvlke5S/USHtnQ4CT9Zww0DbSVSw/p+xa1ddvCuek/U4
         N0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUhUULrLwhzS0xLPrRfvaay/koMCe9Y01nQvllGQrHHqO1T1NhMLN4KxxyNncLAyfCpCeAg5CBrzT2lMYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1OjeFh8M+dbntOnwI23zScUPVzFtwfFgheroxoSPeIGV4IFQe
	Olp07B1J7gNukD+bm4MxTO7UHqBM2KoHXlLAHgKvzouu7kcj9GXa
X-Gm-Gg: ASbGncvpCMWExHUUyEvCDTL137QHVz7t0/vlv/VHwirD2FEqCFjIzyenS5XDAEyYzaE
	tXlS5+4Z3n52owRzDRRa+dhRvDsNpNeNqH6U4dKpQuFxfri/LLKKhcYHBh4x/J3ej9YqtfkcNCP
	EsQVJ575GZEhihPZHCk+Z3mlo8GGBgVSudr7ew3i0uljzLHsP2f178SNNDYrifxQMWlY/GScLq6
	MMB9Me0XC1iM1GPYktTqXblngHUF8WZiuf0pryEMELl2t3M23+KEP1k4Ci7qyA5rf+i9QskttsZ
	z+c2pziSWotslDkIgA==
X-Google-Smtp-Source: AGHT+IF+i9vVTezwqpuU0zG15ZQETlIR5XLCm7azHuYbXnQE3irufSx6ulB6QadTw3IFnEI0XB92Wg==
X-Received: by 2002:a05:6a21:483:b0:1ee:62e4:78c7 with SMTP id adf61e73a8af0-1ee8cad2d0emr21871835637.16.1739879812484;
        Tue, 18 Feb 2025 03:56:52 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1058:835d:65e7:a3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732658987f0sm6550439b3a.10.2025.02.18.03.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 03:56:52 -0800 (PST)
Date: Tue, 18 Feb 2025 17:26:48 +0530
From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, kuba@kernel.org,
	rmk+kernel@armlinux.org.uk, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] staging:gpib: typo fix and cleam up
Message-ID: <Z7R1gKOcN5FdxUxS@pronto>
References: <20250217195050.117167-1-kumarkairiravi@gmail.com>
 <4b1bf65d-bd16-495f-abb5-3d59b65a59a5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b1bf65d-bd16-495f-abb5-3d59b65a59a5@stanley.mountain>

On Tue, Feb 18, 2025 at 10:48:03AM +0300, Dan Carpenter wrote:
> On Tue, Feb 18, 2025 at 01:20:47AM +0530, Ravi Kumar kairi wrote:
> > From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> > 
> > minor typo fix and cleanup
> > 
> > Ravi Kumar Kairi (3):
> >   staging:gpib:agilent_82350b.c: fixed a typo
> >   staging:gpib:agilent_82350b.c: cleaned commented out code
> >   staging:gpib:agilent_82350b.c: removed braces from a single if
> >     statement
> 
> Thanks.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 
hi, thanks for the review and would you also mind checking out 
[1] https://lore.kernel.org/linux-staging/eb8368ee9fff0076ea1f97d154ff2b07d2fec572.1739794938.git.kumarkairiravi@gmail.com/T/#u
In case it was marked as spam by gmail please let me know so I can send
resend.

regrads. 
Ravi

