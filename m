Return-Path: <linux-kernel+bounces-576726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F297A713A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C127A52DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EECE1531C5;
	Wed, 26 Mar 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="E9DVlVR3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1319F462
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981118; cv=none; b=OtQA1UlJ9Q+Dc2AMEOUuOrQZ5y6euwLtKHzWBEHey6bH0FyBr+WMzFXhWAET+o8s6YOqKXBg2YoLYx843cnfYj/0dS+/oTk75cPG4iH39+QK1gSp19AdAl4TpPIcQAHgS1VuvnjUhvCbNYJ138kn6mENDYW7Xu7sMGkhv06qcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981118; c=relaxed/simple;
	bh=1cEyaF63q/x3VGPCgdsugifRXvRW4j5br3BkdE2QNIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIOsi70pvS2S3Y4gZQlKYdTaNWPHa+0bB7HlNEFbBfqLQDVD+5ux5Z0KIX+eZIl4cFWm/q60w5FOLH3Y2uXKR1nmGcKCg0iE1tik07ixErYZ1yLO7sj/RyTk9fxkW/zI6aJecsSC9/GCUxVCYhw046osDTPNQzTAQtnaxawUvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=E9DVlVR3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so10820304a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742981115; x=1743585915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1cEyaF63q/x3VGPCgdsugifRXvRW4j5br3BkdE2QNIM=;
        b=E9DVlVR30wc8A7MqtD6FdhmRKf5WG7HH+cM3IgMzFPkW11DdzCk/yZi5RCW0C3GnU2
         Anhxtw4wddppbTjNDDS94ZpA4c87IK7nroxIk/7oSom/fsWqbOu1ObZLMNL01RrKfuF2
         zZABryYNXVnegKsDzNI6ivgeBIWNlFwH1/n/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981115; x=1743585915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cEyaF63q/x3VGPCgdsugifRXvRW4j5br3BkdE2QNIM=;
        b=E/HiagjgDb27vtHIDts24ur9f0bkyeZiprRQ9DpmEdesS5tilWiS7dchte5S4FPiaP
         OtrzQkNo6i83OlWSI5GJJPfpCEGAIIJ+JtkNLkhQSjO0Yn9Fr+j3y3JCXp91NfP8F5fs
         3ihdCL7IokBfr3sZ6lmmK8NJNNArSvc6oQY1cDO6+dEq67eu267IAvr8htKsP0AGgD78
         nU3HE825YyjbdlSX3ePVfXcXem9JrC15SdikLpfTd8aUMZGn2syPwnqn81wWAaPl3/Th
         bQvp6JRN1FCP8hliO0j32Qm4KQqsR0zaGqS8NV+90EAxYuuq+z+E6I7nx8dAfD+o5pDJ
         zT5A==
X-Forwarded-Encrypted: i=1; AJvYcCXsO3qy7oMMVHc+Loft+P3dbqhLTyo8YTTl9/DTXRA/kZ3x6s60Cd4dlBbUHaE+ig56VqtpbttODuB8DkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkeN++AMTmdIlUopR9eiOi3w4fedp8Zv+aPocKt+BXpgYmDif
	L3SroMsYsooLSi9TV0q680qZykDnINHlvXjeL1/DK34OADuSrcOPGkWY7H2aBpw=
X-Gm-Gg: ASbGnctI6WRESiJXYuG/9Vzj06LrckOdZu51TilXMJTl/rRXnfbxVEhGVr05H4NasQ/
	I7+rt3CJ/2HrkeKXX6FafJBbKXkIQYM/wFKIuNK9fcUQd6eNyLHWFmxyouGyofwPLuLeJt3tEev
	KXoJaT92jDQOE+Z6rV2e31jr/WNaowUrCB9D5/54N3Hxrret+r0+1jCFWVpy6b7W/9JHKbVEZPH
	+mofjC41UZLu7cuoQnf80MJG1+Ps5LXAWr96355xSCT4Ay3A9wEDKkPXM76stQUbO1oQ/0b6bxi
	PTmUm17pfxn8t8hNswLOPacS+piqH/xIfao5rxXiWVZ5th+STA==
X-Google-Smtp-Source: AGHT+IGe+y82L5+gj9QzxBEdZHdajohPp3RW6/DSFWXrlV5r8AaiNFRvvNJjTG5Ejwz4trhnQT/f8Q==
X-Received: by 2002:a17:907:d786:b0:ac2:7ec8:c31d with SMTP id a640c23a62f3a-ac3f210aa96mr1964769266b.17.1742981115065;
        Wed, 26 Mar 2025 02:25:15 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac3ef93e17asm1003921866b.78.2025.03.26.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:25:14 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:25:13 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: 423b87d8-2ae3-48af-b368-657f1fbab88d@amd.com
Cc: "Aithal, Srikanth" <sraithal@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
	linux-next@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [syzbot] [pci?] linux-next test error: general protection fault
 in msix_capability_init
Message-ID: <Z-PH-fYvtSF8v4Ae@macbook.local>
References: <20250325223752.f5tjazbpbblgppyz@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325223752.f5tjazbpbblgppyz@amd.com>

On Tue, Mar 25, 2025 at 05:37:52PM -0500, Michael Roth wrote:
> Also able to reproduce this trace on every boot with a basic KVM guest on an
> EPYC Milan system using next-20250325 for both host/guest.

Sorry for the breakage, there's a fix from Thomas at:

https://lore.kernel.org/xen-devel/87v7rxzct0.ffs@tglx/

Regards, Roger.

