Return-Path: <linux-kernel+bounces-558029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA55A5E0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34D31882CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E0252913;
	Wed, 12 Mar 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FkAfEU3A"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBC156C6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794048; cv=none; b=PAkxbybsV7i+rnfML2jVZIbNJ+Py3QtOmNEMG+N1XmQ0N1sIa+7ChCYy//6Q7SID+84KVA6syIc9Dz4aaCKbcEMIhw3DEH/gDlJus8qx2wOjDdFhAVRzqUL0vhJn3Pz+zr4wV2j1jxzDgXecnKnKXgNYKhJVXajhK9Oacb0BNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794048; c=relaxed/simple;
	bh=ZsCJPcdSe7Tw1kb5p8vquVkzMebfiXs4Jd/L8C/W7qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEfpx0Zw2JPSN2nFB5aYVOHGPAOvoyz/zrHFYIUHVh3b/pRPSS3DurB00noq9O1z8pazDqXFJZhTCgXATHG+B4bgKeSWG7tmY1Aaeez/TFj9WTf25wanwoXie8BgTn0KTFJnyeY2tIp376cMOUJ1PT0khIzK/TKp1Hf5PUUbijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FkAfEU3A; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913fdd003bso9791f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741794044; x=1742398844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SohDC+MqOB5QB3dRD2BBd5gf9MI45ZJLD/i4I7QXdTE=;
        b=FkAfEU3AAD7WkKDxNZ8JyGhXj0iIrCZhRbaC46t4/vdqn+YZBrSneJpnGrNJj3hMWO
         U1XakA4GIOfmDcLdCN3MNG/PSP0rz89/iaQNzosk9+26BFe4iVXC9iEWnuXwQoc4ZWDl
         r2rx1Ncx3ZDgqBpL2S7i7cAN8t8atpAnW2cLhE/Dbse29SGNVr6CF5v3SPilY65pVh5h
         4Cur0ZSV2XvTaSkwjAL82pxjRdlc7PvNyqdz72p2tZyk3kDStBTuHjPX1gCfPMcbkraO
         idsDVFMTNIZ/Lth5ImlsSPis2nu/D77NCBqTTteK4/zHrFUEK8m9LZ0VX4EF9u0IBz37
         BEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794044; x=1742398844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SohDC+MqOB5QB3dRD2BBd5gf9MI45ZJLD/i4I7QXdTE=;
        b=ccg6dkZg+Cq4siivxY8uADXaIRelr1uzdQWcIisLQ65sL5zq+UDQG/tiPmWM5udBQx
         Grn3ETVQO82TZTQZTem4Qj7ShRsuv+Gcw7vxWqGJS96rHsFWQOmBfgF09mdkzKbJOQKg
         dNG7dL+aBahjFkm5LDZIxNq/6iewRImpgj5B0brp2mKJryRq4TyNphILF1ytOtA4NAgh
         n4MBIhndhoMmMXSBOYJMMOAtPr9jT1lDmvi+lvQVXfF77JKdTA1kb5R0o0KIAAAZNQKY
         w7rj6gcummsb7CX9RtFWnEF6oFJx99JUnyfwiPbTkvqvKGfaF2eB6QhgtoTwNTaQkmeD
         hFYA==
X-Forwarded-Encrypted: i=1; AJvYcCVgiFvL5iJ+Y8ECHzBGk+p/4J54Zaf7J29rThHsaUtq4ckC9msaFgERjG5eRfplcQ17849YT3bKPuv0z1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK26D+EIDh6sjRDgZAkaWMGlYgRznZb9VE7t4a5DeS9WNaNHY8
	rpam2nWruHRiQXNkae2tiHH+WQiU2ojbfSE8TMCGqgmefCIN05w3wiDeTEflAz3W48UecuX9gON
	E
X-Gm-Gg: ASbGnctOns+PHyuUfXpGfXI3+S+tSFq7Bc167a3HLhrl077Z/Pel8gfzu3rhMgnnuHC
	ZEp0oulvVygcm03RQumgrfcpwI0mtgn9dr0R+5fG0QpG/NUFt+/xSaSto/PwBFXZasLD3o3ufkv
	Tu8Uc7vCsnsTm+VLhSJBh6mFl46vnI6auYLWqlZbD6gVtNHaDqzkmltbjrMgAjN8e2gVa2MDuG4
	HqmFIsuqn6dh3+S9/rlONNCysYspQwPUNf0Lc6gcxBcWHRJGv6cTI0XvUeQXbHGD1gDVxi+fZYL
	JBLm9nf4MuwFBP/fHZsieo9lfH839M06s5/nqfQN9KTT6cFh2wSiY6MY8Q==
X-Google-Smtp-Source: AGHT+IEI4qphOyuM6FRyf8K5fbXrZk7BGS7097WEPNMO96kH01+ahmZ3y3Q+T0Bk2uCXUnkiggKnWw==
X-Received: by 2002:a5d:6d02:0:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-395671d968bmr82842f8f.9.1741794044532;
        Wed, 12 Mar 2025 08:40:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7aefsm21094101f8f.20.2025.03.12.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:40:44 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:40:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 4/4] Documentation/serial-console: Document
 CONFIG_NULL_TTY_DEFAULT_CONSOLE.
Message-ID: <Z9Gq-oIr8wPGLGEy@pathway.suse.cz>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
 <20250311033133.1859963-5-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311033133.1859963-5-adamsimonelli@gmail.com>

On Mon 2025-03-10 23:31:33, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> When the kernel is compiled with CONFIG_NULL_TTY_DEFAULT_CONSOLE and
> no console= options are selected, it defaults to using the ttynull
> device.

There is a missing Signed-off-by.

The change looks fine to me. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

That said, I would personally squash this into the patch adding
the CONFIG_NULL_TTY_DEFAULT_CONSOLE configure option.

Best Regards,
Petr


