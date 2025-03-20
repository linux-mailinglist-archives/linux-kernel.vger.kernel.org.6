Return-Path: <linux-kernel+bounces-570510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20CBA6B191
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028A3883FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470422A7EA;
	Thu, 20 Mar 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/eHqXvt"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7722A7FF;
	Thu, 20 Mar 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512950; cv=none; b=s7rt5lZHJapBEVAM68JmFayieUzh5eUQ2qD0PrmSud/Oyl5iNhXHXae/mcKsg68ZweCRrQ8RFjIIHuj+aZ1dqRwd/oMU4VSUtA7HsmPwfHorAfL57ngBb59wA4+ny6JRTPEW81k/PnJkZONzwj/1W+ot8TJDP80SqcnE4EuAQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512950; c=relaxed/simple;
	bh=rsqeVDdht3L66LHZac8aylMcpBieGO2/hBxpHx2hDBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svUNUaZf6LSeaTw3MPf9/zW/er8GoXbu1kzlCPoMbWD8bZBJsjp/EgndkeBmNTbsOpYdk1MOgT9uOwlj21e54OOZd/0C1nz6XEndrecXE9EALB33XcDbzjI7WPYpH4jz7+d/tvHYWs46qB1eFK8q4qtBduFGNxOQv42E06XH1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/eHqXvt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225887c7265so3001865ad.0;
        Thu, 20 Mar 2025 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742512949; x=1743117749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdKauJu93MoJRBBc3vto2MePH9Tt2mlxWo5dQZdkk6c=;
        b=G/eHqXvt5cmn2TiBdAijtb40APV1fdMbHO6MTNCCjDhGX5FJCL4CCXXR9ofwUkPw3Y
         Iw0TRwKfqqeo43fYjnbPHmPNMR02a4PByUobfBXSPdRQvz16lTz3NMZP3IeL982phKEz
         gaqki1lcXwBElqkkh+iioT3dQbT+OtFNFB9u5gUyMHC0qPXgFBBzpzL28HLrH+xSOIqn
         9hQH3hVQs08tcG1ymoLQfAHlt9tO8L0UPl3MP+bnRGqhBlXJ7pRL/jxIq3+zOA4whnQ/
         dLbo196bzaOMtOenFLqXBNGW3g0K94u/VxeQ4E6CQg4z9aPAjwsm5ArqF1D3O2Ff9u2k
         4GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512949; x=1743117749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdKauJu93MoJRBBc3vto2MePH9Tt2mlxWo5dQZdkk6c=;
        b=nfzhAOnkoUafOpprRPP4NWI7mkknvomHOOC5RKBCcXGe0zCPTQ7T4nY6d5hstPUZ0L
         2pKC2w5sbnGW02zpiLTVP1s7tKPhHkGnSkSCOK6gXyvMV35t7KzsLYJxMwuufZ/RZT+b
         h3nlXFyzqYWOieswkrJtRbf6I8RujDTZUTeZmyCjahp6jXpvV1rJdigWzqqTs7iZ+sK/
         /ED4PZL9OOXH2kbsJj0kdP2F9cnVA/GPxqu8oklRjrwREpy76DJC3p7n85qxKFZeid5Z
         JvW9/FqmdmiPxIAF8qD9dR0EGxlF1YfObxJthNNqFRTSb6mTLIvFj09DgqBzldLJRfWD
         NRcw==
X-Forwarded-Encrypted: i=1; AJvYcCUh2RsPYwH2LaxitN9RB20aBu209I54ckXd/CQ/meyVcPAIu1Kfw3vZrOpXOPx2yHyG91EsVjBAfuTruxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnmpU7/bdpuUV7Py2NYsQQoa2yflLT8sDt3/6VP7HO7fMckjp
	GZtsFXbegQ29YAZBUofu5mu85mWLyxExW2z/AxiLp9wMYI3z133BKiKiOXliYFxAtN2m/lt+CNs
	9GUW0mvHjPxjpV+9rer8N7cbH4N8=
X-Gm-Gg: ASbGncsSeH9jJusm85cMOOV0v3FVo1gbTUOO8GL+/QHzFiNQAXgfzHDfsFzEXez5J4n
	lRRy4p3nse+YyzQes6HEZPulUWocTTgzaIvEAaNTbSlQUfu8a6Fm7g+aNk0JwB25v7gENjBhymh
	DgEkmz46tI0ggGiNo9nQ1p9YUpww==
X-Google-Smtp-Source: AGHT+IHBYgL2z5SOF0wcGeJiLprNiblgwngPdjLO6Y46Kvg1U568ayZ1Q7zD3yMLx1qf5LEfFZGbpyKvtwUTOO2J9NQ=
X-Received: by 2002:a17:902:d4c1:b0:223:28a8:610b with SMTP id
 d9443c01a7336-227852b8081mr2510905ad.14.1742512948653; Thu, 20 Mar 2025
 16:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 00:22:16 +0100
X-Gm-Features: AQ5f1JpBk6Nt5QqSgaZxqHC41axRSzyVxdHhPrG_3P7bjcNOlmhVgpt7sAY0xjw
Message-ID: <CANiq72kAK84N-2ZzB1tKPQ-gwiYzE=QginDc1Fw4g7FBLDn4yw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] rust: add dma coherent allocator abstraction
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:54=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> This series adds the rust bindings for the dma coherent allocator which
> is needed for nova-core[0].
>
> For v15, document safety comments on the exception of usage on
> read_volatile and write_volatile as suggested by Boqun Feng.
>
> This is tested on a Nvidia GA104 GPU device using PoC code which parses
> and loads the GSP firmware via DMA.

Applied (up to the `MAINTAINERS` patch, as discussed) to `rust-next`
-- thanks everyone!

    [ Removed period. - Miguel ]

    [ Renamed Kconfig symbol and moved it up. Migrated to the new
      `authors` key in `module!`. Fixed module name in description
      and typo in commit message. - Miguel ]

Cheers,
Miguel

