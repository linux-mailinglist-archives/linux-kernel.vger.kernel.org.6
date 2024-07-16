Return-Path: <linux-kernel+bounces-253808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402EF93274B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ACA1C22017
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A3C19AA6E;
	Tue, 16 Jul 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8x96PIE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C514D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135897; cv=none; b=Fkx0SdJB7f0ZOF2Kz0C/+0IwaOO4xVOTFB4wzXo0PfiDpuk0yCubyh8rThQpHivHhe/5rr0QOsf9lc8cWdDZB2qABjTGG6970wxO1yV44vybPp5KFH5DeA2fVYmCkb1KtNAd06uEPKw9tVgek0FA1d/1q9YKZVdLNr6nY0Cwk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135897; c=relaxed/simple;
	bh=Wr1YO6P/uq1Z+nswy5mw4U+M9FBz7LiILLriRwbOnOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPBCkNNfOZoiK9PP67C25DodFuHfyMx3CyROeSkoTJ/rHkz6V9xMS7VaSwvigArOG79f2AFwmXc0jIehJKLabcpJhgJZzcatlE8cdycbJvqVXZenKUeMQQ/fXJfQtrWDKZZ6F24cqWIbWe0sF4PlgREm6rS3+4oLMfokRaXpinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8x96PIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr1YO6P/uq1Z+nswy5mw4U+M9FBz7LiILLriRwbOnOg=;
	b=G8x96PIE8TvbdOVQHGm62aiL5C5IdztJkXBwpNp9MK6lXJz90CQTRo4a+kRUj93FOfxo8X
	I1uVAR1n7mlYkmeiYjlHA01Clq2iQj03PIXsMDkC4g933/+Zc0m47JJoBJVbx+2QZ3Fm1w
	f5FXn4DUT25Q+Lwp4gQ5i+5R4wkvYpE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668--03VLz5yOOqbcB6xM_0FsQ-1; Tue, 16 Jul 2024 09:18:13 -0400
X-MC-Unique: -03VLz5yOOqbcB6xM_0FsQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b7431d8475so117238206d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135892; x=1721740692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr1YO6P/uq1Z+nswy5mw4U+M9FBz7LiILLriRwbOnOg=;
        b=i/sIxAqNd8/CAjDsSX2H6ZREXTN39tBW1+GbGfZQ3LzAC1dwuMH9de1OGDwNpOxz/+
         QDlP+BXG+sVmPBAc2u/6Q8IHDWk1agxtt+IhXW35wcPF4/uza0MY71gyPjXrcLpnvFIo
         rlUd4xXyQRJuPRQW5bP3lNY7nNGvGNPN7B04niMBo9HRfxwpihvYRlG7BhA+UTUHz5QU
         OPvRWURVTL6lD1M5NHoVLftGQHiiuaBEyfqN1YrHTyyTkvs4vH5mUJq8Rmp384/llVpq
         T6HUDYV2Q3lz8ThqjrMfOymORemAcj8diZPIwwBYNmkWg7cdGZqx4VuAUddy/a1VslMN
         sKtg==
X-Forwarded-Encrypted: i=1; AJvYcCVk6170g0Jr8qsyMTw+z7iYtDMxSDUVIdY0jTl/7/SSeg72DblkTQCFOsuM6pjiGIVL9x8X5BxJarIP6nuoTrAM3W8bAPJA8REwnt9Q
X-Gm-Message-State: AOJu0YzLwvdwgx9ZgcAnMM50ehvWq6Yr7+W0kXM02V9MaRjI6+WreXgU
	mobI85xMrXCiNkgc9oZoRgsPaGopj8lbBHmnq02VhDQaDKV7tF/q6fsF0y7/Ardy/TZze6Na5md
	2Zz8xJuQRKyp+6Tqv8sZOrHbrimegxXp9IsAcH8aVHzJyjtT1MwPTZSLFJgSokg==
X-Received: by 2002:a05:6214:e65:b0:6b5:16f3:94a0 with SMTP id 6a1803df08f44-6b780fd34e7mr28935966d6.18.1721135892497;
        Tue, 16 Jul 2024 06:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEVToHlaaZi8d5cLpBxhX5EFAgp6Lf1hrCgS74tI2K8TSgyDjG8S9Kd3CipJStmEA9DBPu6Q==
X-Received: by 2002:a05:6214:e65:b0:6b5:16f3:94a0 with SMTP id 6a1803df08f44-6b780fd34e7mr28935686d6.18.1721135892214;
        Tue, 16 Jul 2024 06:18:12 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619855e3sm30627556d6.45.2024.07.16.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:18:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ben Segall
 <bsegall@google.com>, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched: remove HZ_BW feature hedge
In-Reply-To: <20240515133705.3632915-1-pauld@redhat.com>
References: <20240515133705.3632915-1-pauld@redhat.com>
Date: Tue, 16 Jul 2024 15:18:08 +0200
Message-ID: <xhsmh5xt51nn3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 09:37, Phil Auld wrote:
> As a hedge against unexpected user issues commit 88c56cfeaec4
> ("sched/fair: Block nohz tick_stop when cfs bandwidth in use")
> included a scheduler feature to disable the new functionality.
> It's been a few releases (v6.6) and no screams, so remove it.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Valentin Schneider <vschneid@redhat.com>

Looks like it's made it in a few distro releases already, so I'd say go for
it.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


