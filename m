Return-Path: <linux-kernel+bounces-392642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D649B969E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC74CB20F80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060071CCB36;
	Fri,  1 Nov 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fi1hi20R"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EC1AC884
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482530; cv=none; b=bVWUsauVl7QrFlVEa64tIacD+3WpXLw0Ebhd11KnbhCj8e0D5iQRziTuDtvOyEVBCl9g7Wve1xU6T8NmVMy+HNnX9RHViNMniePIdw1NEgVOpPU/7a/z4oOEBzvu2H4RyX2uOu3ucnUE2T2/LZD2fsk4YzYbGM/2wdRTeXnEKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482530; c=relaxed/simple;
	bh=/qBius67naeqWm12WlNmN6qljDGXSjtZLs4qPrvrH8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBGls0/3JKChaM0Rpy8WP+dXIcDt7aK0f6qh/WnLpbF99NuzUbS2FT2fH/VD9OZ1XaqDbnnQUMlF1pqxAV76jl3cDKlmlQKKzrlFXWwe4YZLe2igFCPDnpbIkQWr6TPERKsXyicxwR+5ExTaoT0i9L8LW7fC4gD8skj7lhixG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fi1hi20R; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso32211811fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730482526; x=1731087326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+aUeOgQnyVbJx2Y06mDKrssyYV6SFstJsPiHxMKrPQ=;
        b=Fi1hi20Rhgn4YibTmlmyranqH+/CeEVr/+WwtUP1H0ejEhw8PKA05GzYHr7akJDjqw
         7/RwcwwJD9vgbbxEOLElfJ/b9Smi8grbVOb2SPKBrIFrcWV2bGAcAclQJu8rBoLxtSpg
         09Ds30kY8WipcF+nhVkvKt8bXPfpN+yqT/eTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482526; x=1731087326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+aUeOgQnyVbJx2Y06mDKrssyYV6SFstJsPiHxMKrPQ=;
        b=Xqw7xMk0F2BNxPSmJP11OFUdEHXd/Fkjx9XuniaStHDslDj1t9Nd8GWMLxPgCKCyiH
         kgjPWeQU7EidrB3x9MM6MFwROvydzRUHJP3v5yM6oZJxQx16HvN2smOaB38aF1AhBphL
         hYNgD2bBRe/D+ONlRaD+MbPoodypdNDtyk10MB6nGPZX/cbcK+8AFp7xiQF/HMUrL2xH
         MoNJF2DS9OHcIWuLTKpGODmlIsS18XsQ+khXRNiR+044dTCNe9Sp5IFKUmEnpG90bzU8
         6og58oIcMojioTGgyRX17FKlQiQn4GVy+qgsvNXggiV79M04umTTDCFlX77KH6+bnhB3
         bHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx3CLOTXsUoKKaGewzNyoZkwwjj4l8yMSOrVXD289I2J1k4nOKqgIJN9SlrwKNGeFN39e3/skBW6/bGew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nq1iNzBT24oLVOSN2zZuQa/LIwFFZKyTWVZ/kOb1i6+fwXoO
	ind9Ki0V2KaJGmcYMQviAWLXTxZN9w3ZiBADvP5rXAggxWoqOFBXkxUlGjZTRMFZqHkGNdXu/9f
	cVTqJxg==
X-Google-Smtp-Source: AGHT+IHC6axYJ650zKiSptDkogxviMTbO9M5Mg+XxAkGTMIN5J3DKJfdw0wQUxUX/QQ4kdqCU3Eygg==
X-Received: by 2002:a2e:bc27:0:b0:2fb:5bd:8ff2 with SMTP id 38308e7fff4ca-2fedb7a2d4fmr37191831fa.16.1730482526326;
        Fri, 01 Nov 2024 10:35:26 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef618092sm5957481fa.60.2024.11.01.10.35.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 10:35:25 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso33838411fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:35:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1NFP0bSo6a2nnQH8f6dosBo23aW2kOSNCkhwpsjK2W3FuWI0wBl4QqC2zkZtfL9Y2F+cI0KpsoyB7eMg=@vger.kernel.org
X-Received: by 2002:a2e:bc14:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fedb813ad8mr42097111fa.28.1730482523665; Fri, 01 Nov 2024
 10:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730474495.git.dsterba@suse.com>
In-Reply-To: <cover.1730474495.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Nov 2024 07:35:06 -1000
X-Gmail-Original-Message-ID: <CAHk-=whvXcpX37UCwGxp6dd3DKER0O76+MPqt1gFXoooBsiv=g@mail.gmail.com>
Message-ID: <CAHk-=whvXcpX37UCwGxp6dd3DKER0O76+MPqt1gFXoooBsiv=g@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.12-rc6
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 05:33, David Sterba <dsterba@suse.com> wrote:
>
>  There's one patch adding export of MIPS cmpxchg helper,
> used in the error propagation fix.

Funky. I guess you're the first modular user of the new byte cmpxchg machinery.

Pulled,

              Linus

