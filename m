Return-Path: <linux-kernel+bounces-557853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0391A5DE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC42166BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04924C09B;
	Wed, 12 Mar 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BNYd2lSQ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374024BC05
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788440; cv=none; b=aBY74E/UBJ8fBz22wu6YgNybHCSaEh/XyQpglHNhJ3CEKw7S0vWlkWmn07lCzxlsfFDQTopn2lkiXhgD71M6gxmM+22CMSOsPFBwOuRcSqJbCdSTs76v95z7u6qcvUR/J2lCyzYScksHbzEkAMY8+6rTFekIsns3s5R7a6rLRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788440; c=relaxed/simple;
	bh=KH3wp93Ri05thIPW6RJDRPjNZtEwM1LH6l3DniegfWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILXgvZd3FEIs/MAShD2h8vTxrgCVgCXgey/onLts9vzwnWO6WsSawAEIBfMWvIXTW26jueURxAW7fUjgFO3SfEwa00kcwzGDTpbrU64I6JdqOwbGL9iKuaWlnyJ7WER/mP/mkWoXE30wnkh+QISrNcUiOJB5oUSzTXDuyFOrbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BNYd2lSQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so14263914a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1741788436; x=1742393236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH3wp93Ri05thIPW6RJDRPjNZtEwM1LH6l3DniegfWA=;
        b=BNYd2lSQFyjpOJPtA+gHI+0E1R7YO2M0SPClTXAkV3Y2YmxeepNlN+QhJ4R169Z0ti
         Q9NpnfQZW9b4BZDO5GFTuu9s2AS4UG/6+tGS7EH9BbBHWiXH5NJJ26TcSHboU3HofHr2
         ixLaRbjp5WkuyzjoVkRa5ngZY2ez2AlITfotI9Y77itVru0gbouZZiWWIJp1Naf1+nPQ
         Pn0szvYXkyUQ0P9PueIBH7vFyd8cOYSEnX0oqQMEBjc1qPjKwRJkwz6w5bK7Ui2zh3Fj
         NIlQo6xDkU53rt8QnAvO/gbS6QJyDtEop6c0W1RyoXWl/lKt2qFl1iPG0tlQuHiQP0qQ
         AgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741788436; x=1742393236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH3wp93Ri05thIPW6RJDRPjNZtEwM1LH6l3DniegfWA=;
        b=CvrboqVRsdDw1TuyJORs9e9RsGz1C5f0S+uLNUAygX8BxTzP5WzbVuYvL44rcdKojI
         FXxMJjScUIrp4Lz7SAAd8P9D0Oww/p4piLV8KL6ilzzcZ1t5SgXjAa+ON0teo2+zh+BG
         D3pD5DxAyhpjDNqkF1MKIv20rSrBD4lspFhH97VTOSofR7TZM8ffzOJ9/rdFyZeZ2YeK
         +qDeS03yzmIN13ZH8uXzjY6FDXkAKuQLsMrYuU1w0uvUO56Vh8hy3DJxAglfc9ZZz1ls
         h/F+ZBPVExEXmTKxck6+HUgNcXX3mkjSJrr5n4KfAVn/jIHovH2xMuzQHihHHlXwNoKY
         uxqw==
X-Forwarded-Encrypted: i=1; AJvYcCUFSrYykeMFnkFzT2SnNeRt6BxDxKDqP9da9R0vwwpf7/6plkbHx79zqNyLdd+b11/aLtc2phr1usJFhyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA03Rdq7NIMyOzs4jxYH4jnwpGxVRqYnLLdpOayRDLXrpjVONZ
	5rlANNDfISi6YmHwpy6Q9iiNOn3fI9CCutMvJWZ8MhXzjf5ZhCy12VrCxb+GDTE/SbGLqzeXuWZ
	vJOekAUP6O5Y9ZOQrHK3/8r8qt66699YHle6lhA==
X-Gm-Gg: ASbGnctBHkPhNoT2NubLgjBitlltcikFytWH50KAy9ybeFCbismiRglncAGLUUpcXMx
	ki4NSlSbEhqJZW+l4OVqjZETNvt+FB5YbrUoe6daq9uin6q/JOq+gAuzySS68ABx3nEzgMNoo0H
	e1tT/DfttAzJE6YHD+oc7cYLjAQg==
X-Google-Smtp-Source: AGHT+IHvsbHGW07mRzank2wkSniIRevs65V3VVz0HyVfxMy8xVMhSSK6Sbh0HLmTu5lUXvhQGvZKTLI0sTvU1IgXHfQ=
X-Received: by 2002:a17:90b:3b50:b0:2ff:7c2d:6ff3 with SMTP id
 98e67ed59e1d1-2ff7cf4f88amr32677988a91.35.1741788435176; Wed, 12 Mar 2025
 07:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312111915.2970032-1-naresh.solanki@9elements.com> <CAOMZO5DaZbRXuv4vgWk9evNcV4iW6gXy2Vjv7oWsnMo_R9ku4Q@mail.gmail.com>
In-Reply-To: <CAOMZO5DaZbRXuv4vgWk9evNcV4iW6gXy2Vjv7oWsnMo_R9ku4Q@mail.gmail.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 12 Mar 2025 19:37:03 +0530
X-Gm-Features: AQ5f1JoWqkrBy2LymfmpbHG_gHAHW6gefRY0T0On-nuBPMD3fer0bQ_5dHG3ls0
Message-ID: <CABqG17gS-kiB73tTC+u-TER2+ABLYPDVM5YyjiqpEzLTb0LbJQ@mail.gmail.com>
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to v1.4.0
To: Fabio Estevam <festevam@gmail.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org, 
	"Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 12 Mar 2025 at 19:32, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Mar 12, 2025 at 10:52=E2=80=AFAM Naresh Solanki via
> lists.openembedded.org
> <naresh.solanki=3D9elements.com@lists.openembedded.org> wrote:
> >
> > From: "Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
>
> This From line is incorrect.
>
> It should be:
>
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
Correct. Not sure why the tool picked it that way. Will check.
Thanks
Naresh

