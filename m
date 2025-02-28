Return-Path: <linux-kernel+bounces-537664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E1A48EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518317A8AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEE014B08C;
	Fri, 28 Feb 2025 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEp2IXiT"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B5224D6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710943; cv=none; b=hE6hd6XuoXAmBAbWqsZRmXE9bIAG/qMHL4bGlDj9ixFrSTYAHMHK8eBcxCvyqHEoobqdoX+OghePMd4FkmKFjbthIazrI633b3u/C8RbD3oyBzjnwZHh2CAOJtWFoEEzUY+Dz06TKnjaUpytai5eOvJLIE+SPPXcCzOV2mi8uhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710943; c=relaxed/simple;
	bh=vzvCWFFePXk/WbMCmsLCnTyJLh/fiuBa/UJXa4Qgjd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2CeuJxnn8jrxwY50rnzuOOl/69GMKG8OLf+412ZRIkkHATj55sp3Tj2PNMFTIKedla+ZeL1ueajwqcZ60sDTz+bHywPmO0hmdiQ3vXdz4XYgYob3XxtoqME8mvI5CgYqcwqT9ci2XUNFey0+PJ4i+UxKDOKsTH0vhItbTQzTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEp2IXiT; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-abb7520028bso215220366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740710940; x=1741315740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzvCWFFePXk/WbMCmsLCnTyJLh/fiuBa/UJXa4Qgjd4=;
        b=bEp2IXiTA4HutZNozLDuFTRst86F3t0BJKnRdwNUXJkKaLWsj3fKMTV9tPrwgLqdUS
         QzEOtvAhy3LpWa/hm42rUr1F76rZOSB3yTHZiASC6NdOnMLaRju2SXUySzD1svwgifXs
         Uqcsbfg/m33BfqFBdb/Hsewa4SolqFqs5pD5C5zqjoaQQQOzou+QqP5BkzU6x3uYYHmt
         DrZEC3v/6Y8ag8cL4D6pEvno1epfMgle/Qy8puWx51Uc2YUil/I8BYlfhGQ/k6NfNxLP
         NIHRj7jQymsJ52bI7qbB+4+ipm0C0Cx2UUANP7fE2VlyhoM6SKxX3JxEm+XJhrMTHTNz
         hh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710940; x=1741315740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzvCWFFePXk/WbMCmsLCnTyJLh/fiuBa/UJXa4Qgjd4=;
        b=vIEGWm+vxh9B4KHpUAlOf4SZBfFQhlppffHdvRTci4kxGsW7Sma4nYgcqsw4At/hNI
         VieIM9M5CElg0X9eqnjiIvpOKDGszcqS+5CEHGfCTK8++YQf3HlrSIOmVxtMpihuzmup
         DW4klaIC+TpuAQ9WdOoo1fSwDbniCsKsk0mJoVYTwvb7aDPl3zUzOLr3Xmqlkda4DR+p
         1qximt/RzCVQTKSKZxetQca2MgsLCaS7hi32xMrpgdesTipKHOqk1qeNFtURw2vH35c4
         zmM5eGgwc8PjVx0erHXO8i/DVV5M9jVDlQIMOApwWjy+bQk2bmYddtepR1VcAdd2ggx5
         2z+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA1QW9BrmI3vDqx36A32hMxxZARVY4kt3YYscw9Ca7WCNnfj0FV5cWperQmdzV8GS9FSN9Olr44McE21Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkdovkkQ3O4C57dQZ8TgxP7k+f4Ye3YWiF1LJLCwFdO8FkCbI
	o4Bb/dhchfOck6gT7dnv/n0i4ck9sjrfra8oTYAAK4xhff5IbpjlDrZ89B2ViaJkR42MAMPHeLf
	PlifIv18sy0tQG+qwFs+3QJSuSvM=
X-Gm-Gg: ASbGncs8rTKzL16iGwHHequ+uuPkJPVktdZzCbJbpwViXxu6pXpxP/8I/JkgA8oDZQn
	usuFUDk+IZfVWW6IQ4GRcGPLvTmAECLtXdf/YqVGUMFBSCwH9uUCu7p0R0QbpuY12Qo2kAQzhDz
	HgiQtnYYZI
X-Google-Smtp-Source: AGHT+IEQtd4jRFDLZfWAi8gpZFqbekkGzWnw9++HXK9B7rSwuM1yAQVX+TTBiviDmb4N5kcz4Jjj4OlYL6K9eMS44v8=
X-Received: by 2002:a17:907:7ba7:b0:abb:ac56:fcf8 with SMTP id
 a640c23a62f3a-abf26802eabmr160328566b.57.1740710940090; Thu, 27 Feb 2025
 18:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
 <5u6rwht2mdwi3t4x3r5gtelruihtvfak24ci32moh2v7z52a3g@qkr2jcjgh4dw>
In-Reply-To: <5u6rwht2mdwi3t4x3r5gtelruihtvfak24ci32moh2v7z52a3g@qkr2jcjgh4dw>
From: ying chen <yc1082463@gmail.com>
Date: Fri, 28 Feb 2025 10:48:48 +0800
X-Gm-Features: AQ5f1Joz7X1GUZUrUbzavyLaxhtwylWXOoaVnnCTs7m_euWrs-9vmGyp_-GQnys
Message-ID: <CAN2Y7hxehoKP0UxPzuuVGv=Zjy2FtrAwgEuc7i07NJUc0ypZ5A@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I'm still using memcg-v1. But it's too expensive for us to
migrate the production environment to memcg-v2.

On Fri, Feb 28, 2025 at 3:12=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Feb 27, 2025 at 10:34:51PM +0800, ying chen wrote:
> > When we use zram as swap disks, global reclaim may cause the memory in =
some
> > cgroups with memory.swappiness set to 0 to be swapped into zram. This m=
emory
> > won't be swapped back immediately after the free memory increases. Inst=
ead,
> > it will continue to occupy the zram space, which may result in no avail=
able
> > zram space for the cgroups with swapping enabled. Therefore, I think th=
at
> > when the vm.swappiness is set to 0, global reclaim should also refrain
> > from memory swapping, just like these cgroups.
> >
> > Signed-off-by: yc1082463 <yc1082463@gmail.com>
>
> It seems like you are still on memcg-v1. What is stopping you to move to
> memcg-v2 and use memory.swap.max =3D 0?
>

