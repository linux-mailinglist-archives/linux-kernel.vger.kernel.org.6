Return-Path: <linux-kernel+bounces-432631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19639E4DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5AC1881509
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8011AC44C;
	Thu,  5 Dec 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsJncUg1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140E194C85
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382359; cv=none; b=guaC6YxF38ukqbqjYXCsVhhOP2MdlQtC2sPoQusE/BzCLaR3TI7OYv6RQDqITm4/NtaAggwd82/vVztFt9ixLhNCJ5eyy/bNa1hrqSHKiIRZ/IHBb8KlIOcslD2OO2BJxWBHQuLhZnwi6LKAQ+DXyBRkhIx+IsODLKOS98BfkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382359; c=relaxed/simple;
	bh=zjJgxmY2y1deqyKR6Stt9PT+fsWAX390mIy9QNV8za8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5NOPwRs/UDVUPfxB+HlLCUFhfo5tPOaxgqCxm6vcVta3/Qn3+Y/XSS/84XUsBF4gR9c7lbRNVT98aJpHryADVyK7bKHFHcva6o9zBHt+E0LVAU5QVAgB4vkVfXznZoiRzE5XxpgQrg9IymHNb4LGgLihKdbfKswS9exMqph2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YsJncUg1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72599fc764bso710628b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733382357; x=1733987157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnVjnK/k6GXXnPfVx21d5+g3wu4ThlrDFA24wTktnFw=;
        b=YsJncUg1a1f6U1pWsuQgbpsAxT8+oIrE0rzyWKTp8gT/FSob/b6EzyyycQe0BbTJE9
         ZWlqWhSXG/rlcmo+XyLQ06rTNJlSGO1tOfNG9wAf+fg6tSHr2ZVuuQjL/hQMeGDcC7Yd
         U1FTktsfhLwuAtLKuR6KTRXHYbPcEB0ND0mGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382357; x=1733987157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnVjnK/k6GXXnPfVx21d5+g3wu4ThlrDFA24wTktnFw=;
        b=oIjO32JXCBZaQGn3tCmHDPy/NkC8P3LNLsnP1f3NRoEXf8Pd0DbbIuEDR+tkAW77Gm
         O4PZ7FlSP5Y09LKMvFMaRzxCNkbFMiXiasVVNZnMsaSmOEs57ximn49A7EvPk87kC5WC
         43O+HgkqmTV0gM5/dMs4XoTvi2nn36Htj4nKHp4uFsCULJpR8i8vJg6kv4P8OH73e5CE
         SjqcUrCKyOn10z2my3RpCSYcNHKUgW9xcReFbykLBNm0Upg5YhO/3f9tQiBSFJtfOBGb
         hmss7kUsKAuXJih2yWByWh4s54R/Pwal8ttc5GuN0EUW7OiOz5Pj53JaIN82yMt6zyAh
         OsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFiQNpGXb14XAUeAVceQZ0YY6XCQuFXFuDasqWVRoeEctH0O1sg5VPXKW8d5baYj2HKpY6QnjFSY2TUUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIf5DexW/VyuKXTC3avJYVSqcgYQha4oNAgBce07yL1BqzA42
	p0NkQ34p86Dbt0WozGtzGbU3F1bG0MkTR/2X2QllN9J4RnJfi3h4eZ227MlQhA==
X-Gm-Gg: ASbGnctqrR4H7pcv0pG2OGp/OoUjvgGZSpvybPM2c8wSRYRHmFd1+Ufk8VGK9JIvx27
	YeXRg7uurV02B25F56bVfiMWZKKT6yNdHgp5OftdIlp7nNKaDRWYTYaIJgICZexjdNjt5NhjV27
	2S83s15o7Ol23Y25xQpiFTdQ00isejky/PrFH/WajWm/g2fIYPmSRCz17c5O6yBThnOJ1DIx1iA
	fkch8Iv6mlxk7By5/UKxWOjttzHGUVppV5OMLpca3UNUiV23LK3
X-Google-Smtp-Source: AGHT+IHmb5xrPz+rTcqYtFMLlN13EqPWRM+lusJzh9gyYi0pYOG3cg9tOPzuRPSq4iV6N8E2CP/VqA==
X-Received: by 2002:a17:902:dace:b0:215:65c2:f3f2 with SMTP id d9443c01a7336-215f3c56e3emr34471825ad.6.1733382356790;
        Wed, 04 Dec 2024 23:05:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9dafsm5958855ad.120.2024.12.04.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:05:56 -0800 (PST)
Date: Thu, 5 Dec 2024 16:05:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Desheng Wu <deshengwu@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: refuse to use zero sized block device as
 backing device
Message-ID: <20241205070552.GE16709@google.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
 <20241204180224.31069-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180224.31069-2-ryncsn@gmail.com>

On (24/12/05 02:02), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Setting a zero sized block device as backing device is pointless, and
> one can easily create a recursive loop by setting the uninitialized
> ZRAM device itself as its own backing device by (zram0 is uninitialized):
> 
>     echo /dev/zram0 > /sys/block/zram0/backing_dev
> 
> It's definitely a wrong config, and the module will pin itself,
> kernel should refuse doing so in the first place.
> 
> By refusing to use zero sized device we avoided misuse cases
> including this one above.
> 
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

