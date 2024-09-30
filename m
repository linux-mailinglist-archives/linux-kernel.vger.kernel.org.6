Return-Path: <linux-kernel+bounces-343526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD8C989C08
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C069B22F84
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F8916EBE9;
	Mon, 30 Sep 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrDY5IMh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADE161320
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683006; cv=none; b=sb/ZvPztS/Rz/sjsPWmkxB4rKXpCXeNDr+j1+Y/ugxF+YViz12T4NPizcq9QlTHtd5/lcRj/z+38sxM8k2W72cGjN1coxwOFkZMuULa6O2PTDa+Dk5a7v3k7JLVxQe9nyR1RHWWqxyhLZ/b9tJksHDxef3/P0pOb2uBPAQiQlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683006; c=relaxed/simple;
	bh=opIQ+15UPIlBq6oK2ZBUTlibM3yyXEGkuISr1NYeRDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDXH2jgTJnCCml4Zpq7cZZ3TDcVCbV/WoJ9hoHCRm5tMgzl1NIISWG3pWNQdZFMK+ElktU2s0XU4Cu6qZ1D8ft+/qMr0jG2P2PoStJcNHLF6hUCJggJHBWNVKMSts7put3vrY5m3c02ctQkEX8T1tLl8uoN7wx4aehygHYxT7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nrDY5IMh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso1945824f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727683003; x=1728287803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opIQ+15UPIlBq6oK2ZBUTlibM3yyXEGkuISr1NYeRDM=;
        b=nrDY5IMhRl9eMFCP23ybdONr1wqPlqySshnAc2109Qjgzu6K7nj1IWTRvqr6p5KVUb
         qeJNg1eem1/eX+2WAVkDTBk5Mn8iwxB6/6dco2eyKtC/K8MBGy7H+5aKm5MTLIrHP4Am
         gWF6R+eBnDOnPBf8MMvrNmERS7ezcIy1L5T3M91Ou3sbi8clZkwqBynJOGqrEJCQrHp8
         VlO6eqjCuQdBYOjeWMGGWdDeyAn/xY+4SPCcFIvqX23EJqYU2nE5gfP94tHuFNbB2eqm
         PRz8Tx9xmvuXNa1/c+EKLGw5tTJ8sILRNexVIuMFdKuhfHna7fntFOr17ZtUubx97FTj
         kq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727683003; x=1728287803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opIQ+15UPIlBq6oK2ZBUTlibM3yyXEGkuISr1NYeRDM=;
        b=Fk7PjswV/4tcfHt7WaXwRcoTdIU8nGrjreaHCR0Y0/WuURvFYOGOFjEgkDIZuTQaa6
         d2EHVU/coF71r3MHZ+z/dfAmnqCaDaedm0BHRcsS5IPTLF6V9BuFVmqhiodrLSuyLjKv
         XdkMw5ODeC1BgtdosYG/pxtyBIX6QAXZyVvlUKoBtSRLEFQj9nEE/E4f9Ct8/vyn57FV
         qWILzk2IPHNJ1GFjIPUKbsgZAfv+lVkGGdLeuQlWg3NZ/A6lQ9t9xSzcnbtEwsb7pk1w
         X2Ml5uLmuXudPNb8NXl7Q6O9dwlU7YUuRh6+OY1qFlFVZLs5vgF+OWdhsFaoDKqeOL5B
         UFSg==
X-Forwarded-Encrypted: i=1; AJvYcCUMT+PCe7ASyhbeiW5WnL6fwvJq8vGWemJ0duU/suK7HyqExsUrbI1P8v17HlKfwGLlhUcDkUjZ8hGzij0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WtwwwIm+3CNeygmvhOKelVK+PexdDu7SQOkkKOXXoykO0RSY
	FjBu1/Q+hSMVojzUnh2AJgcVLJ9nTMMrVK+r4EvBoUGrh/gPXOGcx4E1uuzRLITxxwoEZYF6n29
	Kau/r+Fqg1Qr5ta8tGoow0xfc501g36MzkAAq
X-Google-Smtp-Source: AGHT+IGhGaW1zqKT8yn05vWWEP8GLZvyvXqiwd5BvKXnlWTUr88JEBapDb2DjS/xyOHesOaTzvQckUMnBcjk8WP2CBQ=
X-Received: by 2002:adf:f582:0:b0:374:bb32:656c with SMTP id
 ffacd0b85a97d-37cd5b12572mr7051985f8f.39.1727683003348; Mon, 30 Sep 2024
 00:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918212052.8790-1-nells@linux.microsoft.com>
In-Reply-To: <20240918212052.8790-1-nells@linux.microsoft.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 30 Sep 2024 09:56:31 +0200
Message-ID: <CAH5fLggAVUDVXOm3foVnLwyp5=dZVckut87FdvURgXwgZQNYLw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: types: Add examples for the `Either` type
To: Nell Shamrell-Harrington <nells@linux.microsoft.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, tmgross@umich.edu, 
	linux@obei.io, kernel@valentinobst.de, kent.overstreet@gmail.com, 
	matthew.d.roper@intel.com, kartikprajapati987@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 11:21=E2=80=AFPM Nell Shamrell-Harrington
<nells@linux.microsoft.com> wrote:
>
> Add examples for the `Either` type
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

