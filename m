Return-Path: <linux-kernel+bounces-182910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954488C919D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BF11C2117B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992244503C;
	Sat, 18 May 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NnFE5aUi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00979DE
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716048246; cv=none; b=IJxRA34q0+XcjIOPSqGpKFt7QVwd2+XoUATHUwzruTuC8pieBA1G4N1u0ahc4rdQInsU4CbGV1Xef3RdWzvmF5FP6TQxtKgZQ4Y3ktpo5LU6T4RqWibSsQskY2X2hUnsXwhrVm0tMgkPd5HnOxoJqWsQvKpnH/dPNxifz66+x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716048246; c=relaxed/simple;
	bh=sdPZlTrMpKd5RBdiT5A3YpoFv8oJpNHx4WvhcPbtetc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpLHklE7hRKu4q/6KReOWw+LRCrsYyy2nfovYzqurBEd++sebjLfA5XJVfx8TtFz3godaXzseoglgtYl6y0yfSfJLmWgIBH35GwtNiJ33ME5fQmp0YKHqtxumLKUw/vuI4/h1H0qWNoOWZuYNlXO7nyxlJEWxQC/PpHaEtUVr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NnFE5aUi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5238b7d0494so1985335e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716048243; x=1716653043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bja8TUJ/IH7hcTFRn8iIOtWUsJ2yx+Ps2lUDd47zm7I=;
        b=NnFE5aUi6IxSwXT4Agf549RoUt6cEn+0a03YrJpupOkgUgPnKiLZZJaWrvR/wlbHuT
         mgjXyhB9cYPECdHegmn3LnygoTSFtCqm4s0KhB53dWp4grLQmRsFkSHHD+M/ea5vwPaA
         T/1lbXloO/v8uhWqEXzqtfudMB6lGNm0UtHMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716048243; x=1716653043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bja8TUJ/IH7hcTFRn8iIOtWUsJ2yx+Ps2lUDd47zm7I=;
        b=j7CPubKqU9ydrIfh2xllAKOQ1zElGJg0Y5LrRCgali1XgrWt5Ah90haE6KssPkKvWv
         Bv7sKGhMqJ0LV1VFvTe2/R5IMMoeV2aOYJW8SfDw3UwOR5eo6HD0sKxENck9PijXkmTF
         mPJ7LBfYC2WAlPBkPKHYRCQgoMnpFL2mfsDRjNvxcED7EhSfjGplhMivGLSjsPk96B7l
         /oPl4t4KNgOj/wr3oZRQDMinRpOl4PyQ6OwUjGhEqCk7sedgx5Ver/BLCptytJnTjODo
         L5y/K+ySK1Ctbgcec4NfPWVpR7NN3g90QFp0iiWCN8hZVcrxrDeOGrjuMkW01MlbS4aH
         nLzw==
X-Forwarded-Encrypted: i=1; AJvYcCUdsje0WOXZ5FQLVLdow09i2s68gv+QXJxZvZR2PfQarVDIMJ174rPciTds/06fnCa1mssZqP5NgtpgbQIirxUjanSnqfE5Jg+kEcsr
X-Gm-Message-State: AOJu0YxV2cqaGLN5yzs2KhW62xBtsK7vttW3ILthcPdLY49yLyCBbRgR
	ihYE/T4J+ZtSJmtPxzxGGrYfvPaxmNthsuTVMJ5/uzD2SC1pUnanv3TYuMWe/GNvDFqr1VbYkBs
	UT5ScMw==
X-Google-Smtp-Source: AGHT+IECr7FuXIyVu6ieLOqx7hIY+LzBdv1a9XG7x//q4T8DqTxdOfHgwIwTbi/oPOl/wpfX2E/R8w==
X-Received: by 2002:ac2:550a:0:b0:519:611f:df49 with SMTP id 2adb3069b0e04-52210277efbmr18844828e87.69.1716048242992;
        Sat, 18 May 2024 09:04:02 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5750d5f21d6sm3083971a12.18.2024.05.18.09.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 09:04:02 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59b81d087aso526579066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:04:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXruE5YWw8zI6V882JZ+RsqYdfvt69r3fi9H2DyTzS9FTHPApL3KdhY/vW4wFoP+SvEt01J/Lkq2UV+cjPNdORUIxFk8qdCnZKhmoxd
X-Received: by 2002:a17:907:3601:b0:a52:6159:5064 with SMTP id
 a640c23a62f3a-a5a2d65ecffmr2903561466b.52.1716048241811; Sat, 18 May 2024
 09:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org> <Zkg7OCSYJ7rzv6_D@casper.infradead.org>
In-Reply-To: <Zkg7OCSYJ7rzv6_D@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 May 2024 09:03:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgUoZE3jq7Ynm=LtavYK6yZMboogwWtm1fGT1yqh7NoQ@mail.gmail.com>
Message-ID: <CAHk-=wjgUoZE3jq7Ynm=LtavYK6yZMboogwWtm1fGT1yqh7NoQ@mail.gmail.com>
Subject: Re: [PATCH] fs: switch timespec64 fields in inode to discrete integers
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 22:23, Matthew Wilcox <willy@infradead.org> wrote:
>
> Smaller is always better, but for a meaningful improvement, we'd want
> to see more.

I think one of the more interesting metrics for inodes is actually not
necessarily size per se, but cache footprint.

A *lot* of the inode is never actually touched in normal operation.
Inodes have all these fields that are only used for certain types, or
perhaps only for IO.

So inodes are big, but more important than shrinking them is likely to
try to make them dense in the cache for normal operations (ie
open/close/stat in particular). They cache very well, and actual
memory use - while still somewhat relevant - is less relevant than
cache misses.

             Linus

