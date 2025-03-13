Return-Path: <linux-kernel+bounces-560248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A842A600E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33678188FBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EC51F1908;
	Thu, 13 Mar 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="HnpctnXl"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61551EB180
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893300; cv=none; b=Dbm5HojImA5w+NdQ5SSn2L1PKdk5vN8npih4gk6TkUzHCi5t1hkdP+pS+TQyD6G9u4xiZl9/W7RPVrsHF02c4CPBL94QGCTVXReyOwKyr4xFHQ3ZF7dkCZbGJZdP/g+eP1HzOHm4vjW8PRe9E4VzlmNjkl1dm/+gW3ELto2XxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893300; c=relaxed/simple;
	bh=Zb+ZXYsETYl//4H2xcjbCVAdiU5mtxxYtFbhePzBlTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBL+Dsn6XB7cLlPhVTrniDu715+zEMsbsga2taWC7j5vSceyCDo7nEunD7BXduaBVZpylI9MVlo4KHE0vdZpek86aFu6JFasGsAIZzeHOMrZhQFPz4DrZ0wGCDQUTFtQiujjzaq3Uxbm+/K/PgqqVz8giS+e4G7URWSm5Taa7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=HnpctnXl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225477548e1so26464935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1741893298; x=1742498098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zb+ZXYsETYl//4H2xcjbCVAdiU5mtxxYtFbhePzBlTY=;
        b=HnpctnXlP1sSHNqPi+sBd6CeYKJ9gI9vZit7d4kUFDIZa7mM40s/4LHr5MkzAR11cM
         M6vWT80oVR1ULNjERJTMoOnFHSChEPGTWEhxEfePAS4fOEiTfZ1obuavIPamydJaix+P
         IY01HTh5btMgZjo99KX+hlikgBz9u3UNIPIaiE5X96MX0LkKjl/6npUjhTfD4woRh/FF
         qEtxWMOWU9IdZsfwMds4z2UVbqaZrO5tevyK2/jE7lwUnVYpPe3F3CDPErGduHFfkbe4
         EZZQGCnmxRakijxfkiQV8Szb5+poIzI3zr2Fhn+QqRt1eU8Tf7rs74HMjMFAsO5udGRz
         tlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741893298; x=1742498098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zb+ZXYsETYl//4H2xcjbCVAdiU5mtxxYtFbhePzBlTY=;
        b=fIbK4qRKSiL/amUqSzI9SDlLRscxmb7gpqFZVq7FdpJRqjEvAHbvGcVjpi0pjweaZt
         uJeo02uGhON1TYhMvN5y8tt8juDX+u4xxM/CxmgNr1jfgAaXJyDn3sdL2MS+AMgCfgph
         zji0UrOMIRB5xuZ4/uj26uz5Ce2Vwtn1YwNrBC2aB+mErs1dQcMu9448v62+B4XsycNI
         s5uhhiDvBEsBlaf3EyqRs5fV9wGDD/8GoYiPsfWkfYU8luYiqHrKs+E6LTP/gcpZpk6a
         qy0lIoWRI997cVmnPDVKOpej1Vf8Bnp2bWn8KNZO8CA4WeUUtBq/JVj0IfrboRidaRit
         /Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCUorOHjhiCd4yI2Hrzts/IHgGARh7aWZCX6btrNbU9F+YC3jPy6C1hZK2G4DAsJidcgxDwrUAgdx1Qn5uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2i75klQjrH5+oYAqS5jhOODjStbpmia+bU8wqZaZT4ZkXdif
	XeKBrcyTzQ54OPKndW6Ls2KLviLSRW6lfULrtL0BYDwG0CZlwePuJ1EimKeJGVc=
X-Gm-Gg: ASbGncu3gLBc2UJQ2GXlnekUfKXdIxfiTzo5Pplmd4F42Guar4g2ra0Onh4OQNqcUsr
	KA5Woon6vy3ipsix1TliWzejHL8vV7U5GAKsAY5QrcONvNqQwj0hxjM2xogyblIvy4sN8XwAvlu
	9Ft3TZP9Cd9jeNdBZISMum+xz/lfFvEecg446Pnp+bCdbi2+0F9f+u79ELN9y1e1OPtJwn2UW8i
	OR7XUNR+WZzRw8DhkKCvMWt14SraH0zhCWi6WmqqegufWMH1XsIAZzVnUK9Xyl3hbqNHZUOVCjH
	QP1YSolCs6isrtwo1I7xW/AepkUreQJQMGaDGxWRaSWdMzI70NTki4dDVg993netGbY9ugo5dif
	5WWkhV/CnmFh6X/yf
X-Google-Smtp-Source: AGHT+IHHCeOtgNM+OytPitUTVjyp5IT+qMTAy7sJY2A+L7brq+8vKqWK5JWvWBrxjO7CL0wONpevIA==
X-Received: by 2002:a17:902:e78b:b0:223:33cb:335f with SMTP id d9443c01a7336-225dd8318c8mr8102905ad.3.1741893298125;
        Thu, 13 Mar 2025 12:14:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7c68:1792:75b7:f9af? ([2600:1700:6476:1430:7c68:1792:75b7:f9af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68883adsm17091615ad.47.2025.03.13.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:14:57 -0700 (PDT)
Message-ID: <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com>
Subject: Re: Does ceph_fill_inode() mishandle I_NEW?
From: slava@dubeyko.com
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>, Ilya
 Dryomov <idryomov@gmail.com>, Christian Brauner <brauner@kernel.org>,
 ceph-devel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	Slava.Dubeyko@ibm.com
Date: Thu, 13 Mar 2025 12:14:55 -0700
In-Reply-To: <1385372.1741861062@warthog.procyon.org.uk>
References: <1385372.1741861062@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 10:17 +0000, David Howells wrote:
> ceph_fill_inode() seems to be mishandling I_NEW.=C2=A0 It only check I_NE=
W
> when
> setting i_mode.=C2=A0 It then goes on to clobber a bunch of things in the
> inode
> struct and ceph_inode_info struct (granted in some cases it's
> overwriting with
> the same thing), irrespective of whether the inode is already set up
> (i.e. if I_NEW isn't set).
>=20
> It looks like I_NEW has been interpreted as to indicating that the
> inode is
> being created as a filesystem object (e.g. by mkdir) whereas it's
> actually
> merely about allocation and initialisation of struct inode in memory.
>=20

What do you mean by mishandling? Do you imply that Ceph has to set up
the I_NEW somehow? Is it not VFS responsibility?

Thanks,
Slava.


