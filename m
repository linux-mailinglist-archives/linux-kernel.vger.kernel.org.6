Return-Path: <linux-kernel+bounces-378600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA559AD2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F84B22A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E71CEEAC;
	Wed, 23 Oct 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFz0cVyj"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B71B652C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704951; cv=none; b=lpggzANPQ6aGugc0pv+jbNuyrr89423MFhKGj4SPyz/4y8UrhcJTLUigP1gR46BbO4k7EVUPx6XQByQGBfKB5AKiwg7O27oPS8MKlNwQRJb73A0sShPaS66zQOLvu+UmK/gRMOlGjlGzDWrDLytQoJ2OYUaUbFDuGF80YaJgVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704951; c=relaxed/simple;
	bh=l1ShLt+OtBVS+xKf4QDhtx4ybbutxUkbwgwiinHpT3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npV/3HiAmaIv8J8zkimXxyKnaTu456quLZm+JZMtsB+r+aHh+mMWCIHXymFpvK1cqI03/rLXWCk5bIVNaiVkv8TPio1rTGMV3b1bXmU3F+V4J9RKjyqUQAR7xqXEstB7Mgvz2DYjdmKas9bK6DMcWU9CCRNgO/bwoBniVHMkW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFz0cVyj; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b8964134so267345ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704949; x=1730309749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ovYWQjSscguidicVSZDApcP9vThLQFuZ25Zqnn2i2k=;
        b=TFz0cVyjl7abHwOwBE68kSfFz6VqTJOq0NO6M/+IV0U90sftfCLHLWi5fCHzNlBNGO
         nz3KxnkkqHuZjzibyOyfCeHvMzF8bTi3dMFbYsLVLtuXNRVySkPleR7nRWt+fZrbw7C4
         WZhfmIoeycI7WroUbLD6IIMs/4SPJ+zMxopBGfE3/op+mVh6584cxtU0quIT2KhCgxwU
         pg/wouhGL6mh0GKhsvIIhk/EcW7jOHbvxfEDv4DZYG4hlKziRERlEwllJdZOrfE/IVQn
         tQTQEvL5dHJjFjSlosxoGHgnyoLk4PEAG83er2wRTkSbDWGzGovfiJiTM5BUKeO014yv
         kGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704949; x=1730309749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ovYWQjSscguidicVSZDApcP9vThLQFuZ25Zqnn2i2k=;
        b=hb1rXvfuGgTghrlTGIWg/Ex4tKmGXhBNh+A8MRbsHKGE3rXidGBPaaxhKt4/cqz9+S
         +o4MVuPVJMwkqqPzUkppXTFEKrekh0VTTsYsmq8zJuNbno0ePxwtnPYSWAt7qJAyBsoe
         bDnv5klktUXerblzJJAOrXHhIkZjudgCdgEITSZaCAO/80ry+ec15jbPj2uEoi+cK6zP
         top5jJE5sM9K2qjhCxKyUjoB9fBAdaziJSkhYTsf7M9nDFb3WvjKgE2y0SQW4socbTb4
         47TKhAXaMV8uFCM82/sYt+3vd1P3eTCii6GWd1bxAZJijN8b6f/5VQq7y5ClZRc3jOpk
         x44g==
X-Forwarded-Encrypted: i=1; AJvYcCXabgcp51fZZj025x2i9zU9fMp7ZEVkbiKtl/5LPKE54ekrE7mB5HlB2WV5EWxt6aVDEHyjRp30y/49YX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHPh2McSuMC1aty4wYVL4hoxa0XfRgEV+INnT9q1HP6wfLKeT
	7+3PQwCnJn4EIWZT88LxtS2uj5hNL8l/u3prT3zP8qjow23yhiV1
X-Google-Smtp-Source: AGHT+IFNcfiRI5mXvySi+X2Q1V2GhkJCnsfc97v6IoePj6n99bdtlwZMFJ+F/+hJRzyQeQU4ZrmN5Q==
X-Received: by 2002:a05:6e02:1aac:b0:3a3:9792:e9e8 with SMTP id e9e14a558f8ab-3a4d592c8famr36322185ab.5.1729704949159;
        Wed, 23 Oct 2024 10:35:49 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4db304c0asm2501945ab.78.2024.10.23.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:35:48 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: dsimic@manjaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	shimrrashai@gmail.com
Subject: Re: Re: Thinking about firmware and hardware description for latest Rockchip platforms
Date: Wed, 23 Oct 2024 12:35:14 -0500
Message-ID: <20241023173514.4538-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b12103b968cd5817f25deb7277d6054a@manjaro.org>
References: <b12103b968cd5817f25deb7277d6054a@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-10-23  2:46, Dragan Simic wrote:
> As you noted already, the DT definitions are fixed and improved
> all the time, which is actually great.  However, the backward
> compatibility is ensured, because newer kernels are guaranteed
> to work with older DTs, which doesn't mean that the board DTs
> provided through firmware should become frozen in any way, as
> explained further below.

Thanks - my concern was about backward compatibility so that if some
user did not upgrade their FW but then tried to install a *newer*
Linux found things mysteriously breaking due to that some DT revision
in code had broken the backwards compatibility. Of course that could
also be considered a bug, even while new FWs could/would still be
rolled out.

> Freezing anything would be simply wrong.  It might look good from
> the perspective of having something "stable", which is similar to
> how x86_64 firmware works on PC motheboards, but the continual
> bugfixes and improvements are actually extremely good, because
> they prevent various ARM boards from effectively becoming abandoned,
> which is unfortunately rather usual with x86_64 motherboards that
> become so "stable" that some nasty firmware bugs are never fixed
> and their users are left high and dry.

Yes, I'm not against new FW upgrades, just the idea of users *having*
to upgrade their FW simply because a new kernel came out when nothing
like that is typical on x86 or at least in my experience using it over
many years).

Note that the situation of a DT upgrade that is obtained by FW
upgrade breaking older kernels, i.e. broken *forward* compatibility of
the older kernel with later DT, isn't so much a problem because we can
simply keep the older DT in the FW when issuing the FW upgrade, as I
believe there is a facility for supporting multiple, versioned DTs in
that UEFI package [and if not, it could easily be added]. It's the
backward compatibility that is my issue because reflashing FW, even
though not too hard on these boards, is perhaps more heady for your
average PC or smartphone user.

That is to say, I'm imagining the case of bundled computers
pre-shipped with the loaded FW and OS installed as usual and someone
says "hey they got a new Ubuntu [or whatever], let's install it!" BAM,
devices stop working because they did not upgrade FW, forcing an FW
upgrade in a way an x86 user would not be similarly forced. Though of
course, that could then be reasonably called a regression bug (as it
would appear from the user's perspective, not knowing about the FW
change), if backwards compatibility is indeed already a long-standing
policy (and is really what I was after with that "freeze" suggestion
even if it itself would not be the way to get it).

 - Shimrra Shai

