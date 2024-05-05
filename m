Return-Path: <linux-kernel+bounces-168901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9878BBF83
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DA11F2174E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8F6FB6;
	Sun,  5 May 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/u9CJUY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD83D76
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714891719; cv=none; b=lueJONLqovzoaGchQ1r8n8XFYlehr7h++u4cdKJoNUKmJB1LRmZSGnJzIQAEI0M0LPYWR6kns3RPY+Tas8b6WqshPiDVoZwCZ905eibbozBj/NbnAUXQL8eFXsTI61iLHjBti19HE9eSMhSc6bDPm5aGZKGwyMVuXscoruRzW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714891719; c=relaxed/simple;
	bh=RXOAbrpDgpGLFXAx46orQOJKxD+B8azOxvN9slFpzaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEEY9jfPRh7jxTSkMAPAa7OvrCtbesw8Yajx6oxyVMpjgX2vdJN2Cugd8bEKiCVmtVJJKwCBFBuTgS/rLt+LhPTAcC+LGGJcXuTfyLQ3TQjEjI0hnHJXY+UEX6U54mhpnJeIS6b5V7baIuIYpRiG99h9ZvP40l5BTgvq3ntY4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m/u9CJUY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecd9dab183so24829915ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714891717; x=1715496517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHhjXzZFksYbod+Id4KGQBrNHX5j07+oNfn2k/vQfaE=;
        b=m/u9CJUYgIhnVbD/S2wlLnDkC75h94E7KFUGjobsAQNKsnfNij5kfDsaDY5B0wufe5
         BBuYTljSYdNBtfFvgmU2IhzoJCi3ZOOzOjWRK4q4HnsarugokEoCQxh6yTB6wg22btWW
         MIMI8RCM+FGJoY+PKKmdsOngeWbvYKR8evOVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714891717; x=1715496517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHhjXzZFksYbod+Id4KGQBrNHX5j07+oNfn2k/vQfaE=;
        b=KptLhxR0W0CZ1F2gaKuURC4WbBYErnvQNz3xknBFqdN+cKh3+/QipK8rXcq+xsRNbH
         1UXRmCmzua3Zkzj0StWm8ImuM09gOOJU7XvMMp2+Fg5us9JesD+rpj9UAM19g0FKMDRt
         jHsoxXIszMPrsDKC/5Vn9ajbPoc/1hWA/nWJrYjeWJyKoSF3Of9l7RNXeYqhMRBKlrgs
         jqH9yb3nCWNuSKpXzYHz7nZTy73W/3wUcFfFDz65aQ1GegonV6sucYEPxTp6z1iusp3i
         T7KXb+Xqmsc3vOwAU5qdo9zoAqKQg17gCO+iAXOCNGzgRsnbG85L7kHvIqEzeZKEsF1t
         dnqg==
X-Forwarded-Encrypted: i=1; AJvYcCUSdOibIrM/XrErPqTZDgy8BbAANeddR7SxC+m2XXYOKoUHpEP6Awun24aTv5usbLIG5ApwdAeHjYZy5guQ1I4zrmAo+N6UyQ3E1pQ0
X-Gm-Message-State: AOJu0YwKSPaug1EmuaGF2s21sxr4MaMP00mr4sEUCxPGsVuaxj6H6Xbb
	s4yOsSEVad4JIyktydrQzmRCDF40amFI5UMVgxaeWyBmJbC+Ga2/4KWPpG6w/X44cEo4QM/vFTk
	=
X-Google-Smtp-Source: AGHT+IGHFQZeorrILclN2v4X0ie/TALNwsi+wwr/27nntpfpvsDMRS89bEaJxITb4Y8FGrRf8qcf7Q==
X-Received: by 2002:a17:902:dac1:b0:1eb:7162:82c7 with SMTP id q1-20020a170902dac100b001eb716282c7mr9274029plx.18.1714891717283;
        Sat, 04 May 2024 23:48:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8263:3b89:bcee:2ed4])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001e7c05cf1a2sm5978407plr.112.2024.05.04.23.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 23:48:36 -0700 (PDT)
Date: Sun, 5 May 2024 15:48:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, Minchan Kim <minchan@kernel.org>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 08/14] zram: check that backends array has at least one
 backend
Message-ID: <20240505064832.GC8623@google.com>
References: <20240503091823.3616962-9-senozhatsky@chromium.org>
 <202405041440.UTBQZAaf-lkp@intel.com>
 <20240504071416.GH14947@google.com>
 <20240504161004.f5a0aab5e5aa1033d4696c20@linux-foundation.org>
 <20240505043957.GA8623@google.com>
 <20240505051305.GB8623@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505051305.GB8623@google.com>

On (24/05/05 14:13), Sergey Senozhatsky wrote:
> On (24/05/05 13:39), Sergey Senozhatsky wrote:
> [..]
> > > I guess just pick one if none were selected.
> 
> How do I pick one if none were selected? Does Kconfig support
> something like that?

This triggers Kconfig error:

config ZRAM_EMPTY_BACKENDS_FIXUP
       bool
       depends on ZRAM && !ZRAM_BACKEND_LZO && !ZRAM_BACKEND_LZ4 && \
               !ZRAM_BACKEND_LZ4HC && !ZRAM_BACKEND_ZSTD && \
               !ZRAM_BACKEND_DEFLATE
       select ZRAM_BACKEND_LZO


drivers/block/zram/Kconfig:17:error: recursive dependency detected!
drivers/block/zram/Kconfig:17:  symbol ZRAM_BACKEND_LZO is selected by ZRAM_EMPTY_BACKENDS_FIXUP
drivers/block/zram/Kconfig:52:  symbol ZRAM_EMPTY_BACKENDS_FIXUP depends on ZRAM_BACKEND_LZO


I'm a little surprised by this - EMPTY_BACKENDS_FIXUP does not depend
on ZRAM_BACKEND_LZO, it depends on NOT ZRAM_BACKEND_LZO.

Let me Cc linux-kbuild. Kbuild folks, how do I workaround this?

