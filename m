Return-Path: <linux-kernel+bounces-322224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0579725F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B14DB23B29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506118E77C;
	Mon,  9 Sep 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6cTQc7U"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E218DF8F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926102; cv=none; b=QAeAUS5EgQZUBk3x9jAC5Kk0q06gI/XfesW4Qneb2lMxrk0s+reWCE+9zijm7EAs9vlaeZzeO3TV06JnQjtEdR7le752GbgnnD8BtlU3wZaDjuJYBTqR5OpLV3w2U8/1nh1RZge2Kf9HFmmI/8UBw8LHubLEEJUK/ei6+Ctmcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926102; c=relaxed/simple;
	bh=M1KoFSpNUOLVXT1kP5VICXcC5Vs8wFtp9teskKlY70s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=jHdrLfatHS2EnrVSW1aOxh7Vi/JFR5Y1b1bg7UvYxAc+iWnfDG+U7vNLk0bwUH6RSgt3+Bdfo4N97PtYrnrMRppv+JhD9RtJrs6v3uoKS9gWzTCzdpjWnqUAp3xbWI0ABIKiLalfPDHWPQygld1DXyHa0SGan8ey90A2TLorouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6cTQc7U; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-846c4ec2694so1488414241.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926100; x=1726530900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxX5C1PVQFhcpEMOTxZjcoasZZvFqrJMsr5iTanZpSY=;
        b=E6cTQc7UZMiO4XetpoUFY5tCaa6W0UIdCJNmHgz3oasEO/R0ieuU7cplZNReNP/xuq
         wtIWq9g8AZXXxCQMP9LcY1A9VLZ0ibmZyU69T12/GEe3DcyFjrNAJPY7WQN7y+OQtayl
         d79qgWELFs1vXuAZJJ8phN3lvugX9A/GWkfqEvYo3ZiT7wS8fwiJBElyLUyg+6ynJWkX
         i+r7ma7gNRLJr9Ck0Qi6YSPofbwpYRhpMPn5QBrS8Tkwn7vD5RXUPEArVWl3BgAseIVT
         jHkTdt2zdqT5vigvdmTeHCfu11ohfeQNSLkW2WkADq3txHGJT9wUfiXDt9St9HvdfpEi
         DvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926100; x=1726530900;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxX5C1PVQFhcpEMOTxZjcoasZZvFqrJMsr5iTanZpSY=;
        b=s/jkD9ffq5NuuT52tgTbFcjbiw2//YJaRyCdcfVTvlwr9tb/e1DJ10V52h8y/UdbEI
         X1vVm6LQvfh9CLsiKiB3xUG0TY3AnHvFgSL4l9xPgNymbxMksCn51Aaxm/YJz8NeMGrl
         JGU5w9xQ6mIcgg04s8+BVnY/cw9R5q2PltDf43Azwl2hV8xsEDgcABgqO4NJPx8TFv6g
         cL3vg93SGLVy1RkqXslIynyOSq4LOHZnQudw5l58apAb8kHr/PxN7SOUBd5cRH5vTJ6g
         yylM/1kY1AxLdI0Dg0JeWPgYIAVnPOhjBe4qzdzQFSxC4roIsqK6883PZzCfU7ocL161
         dzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkz/aeTv7h0wWvnkKEkA0nWrSdLTuqYaqgAjv/PPXvZNwoKk8bP+U4MWyUNulKFp4wcQWd2LfpX9VRobA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdhzG6sEJ7W/bowGLoO6ggJjIrj5VJ2VwwNOcjlU5FhOxUkzc
	dk69NJNMYo3Y7971qL48ns2x6rPssR7YRPcM8SJ1JqYhKxPW6IhzWI+ydjjW3t2gSIsohVbyQRx
	iXe4SPHMtvaMiGv/VeH4/03GS/2GFKwGjmwM=
X-Received: by 2002:a05:6122:2a54:b0:501:1895:203a with SMTP id
 71dfb90a1353d-502142032f9mt15753354e0c.7.1725926100090; Mon, 09 Sep 2024
 16:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908192307.20733-3-dennis.lamerice@gmail.com> <346199.1725873065@warthog.procyon.org.uk>
In-Reply-To: <346199.1725873065@warthog.procyon.org.uk>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Mon, 9 Sep 2024 19:54:49 -0400
Message-ID: <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on
 netfs library page
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I'll be sure to revert the "fulfil" change
and correct the pluralization in a new patch.

Dennis

On Mon, Sep 9, 2024 at 5:11=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Dennis Lam <dennis.lamerice@gmail.com> wrote:
>
> > - * Allow the netfs to partially fulfil a read, which will then be resu=
bmitted.
> > + * Allow the netfs to partially fulfill a read, which will then be res=
ubmitted.
>
> "fulfil" is also correct:
>
>         https://en.wiktionary.org/wiki/fulfil
>
> > - * Handle clearing of bufferage that aren't on the server.
> > + * Handle clearing of bufferages that aren't on the server.
>
> "bufferage" wouldn't be countable and can't be pluralised, so the fix sho=
uld
> be "aren't" -> "isn't" instead.
>
> David
>

