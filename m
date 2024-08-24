Return-Path: <linux-kernel+bounces-299842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D681095DAB5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E8CB227FB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB4828DD1;
	Sat, 24 Aug 2024 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hcb3fMlO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722815E8B
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467254; cv=none; b=EhUhnNELUuwVMo1oS76b/bVa/48RMYYT8pqXlu926P7pwVi7Vm8JpgYKXbLkw8aIANE9sBPsBOjF7WEDDoH9kypLJsLst+HNohr5vfLqNJ0c/wuYwvi8XgJxnNr4sbt8CNZk0qC4HHRK5xVRxK8xFkWm6gg85TZCxdqyiNNPhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467254; c=relaxed/simple;
	bh=Azva8laTZ/2BkvfzyODM+ZKSQYox1Eu/+5PSMYsEbtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnV+dpFNDPX/e4bRePzjVpAPrDdp4G6H1WxsTpuBL3MxLP60vsIpIkiR+9ohXyX6UcuMuCCCiHw8m8PrI+HTTEYYNxxNIycycJX5wlHza3zW1ajT8NvHM12vRtr2VSx7jo8MQ7mqy9MNABoyIdXFiZZxnEXaarFphtIeKLRdN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hcb3fMlO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so4203170a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724467251; x=1725072051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+tZBKZfR9xLINW1ciKZzSilx+udfG+brXdL2+OvlBY=;
        b=Hcb3fMlOSN78loNkIAmehRWUHWwjNVuCGkN2bvgfSxYvByJI+lqqiydE0P2PJhbmgx
         xJa0dnoEmIMGREDsR/0IiLy6yCOfkxhrLOZW2mnNFFLb2t+efZvnE3RFRE6XVm1q2GSL
         L5scbiMVtMARuHUGXelLYIjVcfMgXJuKa6h08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724467251; x=1725072051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+tZBKZfR9xLINW1ciKZzSilx+udfG+brXdL2+OvlBY=;
        b=xGfRf/9IVf9zFX4cSyVjUkMN5wr2T0tJcFLZZNrrCPL3W2OE0BHbcqYwNmTW5/5on9
         9EuyH69Mdnq07YkH8BVKlyeoEcnwPkpWOAiu0l2Cx2YSVz/ERs2HHGMTvlticZZKdUKV
         bGhM3/B2eUD2Q+EQ/QwYzp9knMGTD8PH7oVu2gDlOh6KAjX/3Umd/9sbY5BtCRPwA9x7
         crOJCpGq40ihFMPpvvFBzs2WtZMfXWIVb0ZH+ohaVt/9iuou3UJIQ9AiDIanQ73dlulG
         5aCneo7petB6btsBhWQ0MEpig03/F9R97ulGsV1vlzVgi6/43iNTeb1aMV4uxp2NTIAD
         6R7w==
X-Forwarded-Encrypted: i=1; AJvYcCUrfDlklgBAqUeMmcQj227VDeoKR3q9zLu0q6IVFfX9JFU3AwLZriTrKhTVLZ0B9S2Zk/et2gCebCanZ70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTd1EbVKoG43Ev+2qsXxi2Q1AMlbJ+u1UI7EV0gu/w3f5nmXl
	HPjeJzubYojaJkbWGPIwLN9Qo/Pw/b5vukwG8bE8qJ+MoX+AzYJZ7uikaxxPuqwzkMagMfOJJPC
	jTa3eZg==
X-Google-Smtp-Source: AGHT+IEA1vB4v8KqM4QAFSK0T4c9lG/o/RGgRWERh9i3j4U+N4BufhvGQjzbU/Zv6fVhB8KzPqAiAA==
X-Received: by 2002:a05:6402:40cf:b0:5be:d595:5413 with SMTP id 4fb4d7f45d1cf-5c088118458mr3598716a12.3.1724467250858;
        Fri, 23 Aug 2024 19:40:50 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ead28sm2782440a12.56.2024.08.23.19.40.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:40:50 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso4345467a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSqHo2XOmUhxUkuRy2arxxM4Bc0V0DfpsXdTbTQSXYd1ML2zOtRJxSKgbcj4EGDFJ0I/1C1TPweKGH9ds=@vger.kernel.org
X-Received: by 2002:a05:6402:26d3:b0:5be:fc0b:9a6b with SMTP id
 4fb4d7f45d1cf-5bf2bfd55f4mr9202951a12.5.1724467249913; Fri, 23 Aug 2024
 19:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd> <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
In-Reply-To: <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:40:33 +0800
X-Gmail-Original-Message-ID: <CAHk-=wghvQQyWKg50XL1LRxc+mg25mSTypGNrRsX3ptm+aKF3w@mail.gmail.com>
Message-ID: <CAHk-=wghvQQyWKg50XL1LRxc+mg25mSTypGNrRsX3ptm+aKF3w@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What is to be gained by having release rules and a stable development
> environment? I wonder.

But seriously - thinking that "I changed a thousand lines, there's no
way that introduces new bugs" is the kind of thinking that I DO NOT
WANT TO HEAR from a maintainer.

What planet ARE you from? Stop being obtuse.

           Linus

