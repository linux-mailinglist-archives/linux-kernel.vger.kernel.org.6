Return-Path: <linux-kernel+bounces-245357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4392B1A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D27B22863
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F77514F108;
	Tue,  9 Jul 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX+HUnte"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7F14B953;
	Tue,  9 Jul 2024 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511598; cv=none; b=cVajDFHHyxDHxD6/zkjQROu6G6VMaYdwBfishwRz/I8GRc9mgES3lFPzaQTTbEK6zU+c9V71OGRuuZfntTkXyLfyQDwxIDQHMmPY0sJEBhjpuftlC5yFL0O1ruu9fF/39pOYr4+u6aETAw4uUSZhHtR58bhD9PNgCtyRUhMrxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511598; c=relaxed/simple;
	bh=WL22tWo76BWT65KwutB+1xbSc5DFUkHPdjYuOrTOH8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iwk236RkgNgl3Va/JNaPZ4E2nWHEAmAoDEZcBYYU8V6F/4ox/XgFNXgEAUhvyW4viGESYiPZVYdKH+DF8/iY29kveLBNZretxjuvZV7B7socJyiB98geXGi0rA2NPd+g/8DsNYjCfFBEljNVPnyXlpxMU98HCu/vXvIcZo2p9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX+HUnte; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2607460a12.0;
        Tue, 09 Jul 2024 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720511596; x=1721116396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL22tWo76BWT65KwutB+1xbSc5DFUkHPdjYuOrTOH8s=;
        b=GX+HUntehSdaVUCCeevzlQUtwVDqWYQNNku18aq/q0/8NBXDA0AYuRdDBw/Ogo2a+o
         /Ti8nMok2B/+j74+aJhe5Fu+jh1yHBXnwugheBJmrOaYkejcU+0hmL2bA5/1gBayNYL7
         J+Rt+fNqUYwNwBRLmBENda89XWDIfIIye6IuKyRUQfBNmIjfaMI27XSrBjtAPH02RbbM
         Vodwwu2FIS/8t/yR+phatI18aRjtYDLd339Ve4IR+BFe7xTQ78LE9jh2E0Z9Iono/FTT
         RRpPdIScY7/rzJJjL6+4O1ynwh5co5UEPBXySTK0/+QsUMc3ojG/YnyQmoRZm6eDXt8f
         uPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511596; x=1721116396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WL22tWo76BWT65KwutB+1xbSc5DFUkHPdjYuOrTOH8s=;
        b=u1CEPL9QS6elYK9WNtg5q5lNiNaLLgUnreFlYBPaGdLolOP+Y3efC4FwugNjHfjYs3
         zyA2JaZOq6k0X4lhDSSWeOMSConi5E+QMei3WnxfeCtdStMPh4GHIn88RgPaYXync9w4
         BlHDXxx8BkLDDBTlvk+t/97oAjmhWd4x7JukvaFzWVovcXNxn5t02Zya3AXiWfqtXR9r
         t2UO+M3sKkmopejfl04U0AuzGXeJnq1CSbex55HT88deko/cglmqtnruMWGNJX4PrT1o
         7374jmp/CodaPf7d5TsS26cJ7QyjjXrS/iaWylPHuuM6m1iIQ3YNpSg7X6jPLxXl3DGE
         iNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW63vQ+qrhGwhOFRb0dAWsEcGg16NXBkbjHi1noj7J1ePzq0EcUUzIE8NpRleahFikQZk9WTPyy8xKahlwUzjjC5hYiDLbXuOtscXyWgzwCwtmAByvcONOemgKEe34J7y4O1Vnfkah/FcvKUnQ=
X-Gm-Message-State: AOJu0Yzddzvdc9gVPianLfR0Exqx/EHHsejs0EEK6irHn3pd7U9oLe/A
	+qOL9bMJK5y5EEmRlqHI7739VaNck0Tnuj9JshkoeDsd9ILY2kdSk+tsm23vD/ucVF8wlttcET0
	wbP14b1+8apn5XIA9+KfeyLXMbP6Swv3X
X-Google-Smtp-Source: AGHT+IHdWDw9UdaaXy/Z7v8pfOYL798N0YW8rQD1Bhqk0iolkyAOuJVTMcEbL3Q5tWEHY5nmkUKA22P8obNbE55vdW0=
X-Received: by 2002:a05:6a20:3d8a:b0:1c2:912f:ca70 with SMTP id
 adf61e73a8af0-1c2984cf0c0mr1628798637.42.1720511596600; Tue, 09 Jul 2024
 00:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529083452.779865-1-aliceryhl@google.com>
In-Reply-To: <20240529083452.779865-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 09:53:03 +0200
Message-ID: <CANiq72m0=Fmz8yq6r4Xp-xd3eN+CGsnyApkFjNxjO4H6p2RxNg@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: fix typo in docs for GFP_NOWAIT
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Fix a typo in alloc.rs by replacing Ror with For.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks!

Cheers,
Miguel

