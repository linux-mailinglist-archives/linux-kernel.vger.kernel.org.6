Return-Path: <linux-kernel+bounces-514721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB15A35ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D231892C90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4D25A64E;
	Fri, 14 Feb 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QYT4nrEd"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335A25A626
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526521; cv=none; b=nLF2I2nUiXEXi+rDREiYdlywfOFuLHw9SnWPzPk3HtaWH5nGUEQI1jZeNlbAsqDgizQnVfvOjxwgLDlefHZhbkJkvwYxTHG/0jzEBVwapUWCSTIEVvZNU28pmjh7u9qFzU1F46eZnNJILdah42K5uH4JG1trdjG6hFPsaHFaoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526521; c=relaxed/simple;
	bh=KE/1PS8bSk4dH0R2K60/pmTjlC5i51phdJ5NWCLMzN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+n9FeYcFwmKl2YapCNCW4w2Fxc4HgPUW5N+yFQGfiKkf9fk+x1RX747tCbHwaybLrW/QHHEutH00vxQ98/fGBobl267i8zRuQzia6dHlg7qUpoq1TEi/uHdCk/yGuVXVUQny8emXLw4Xw0rJpRgdPTX+mOFLFb3LMg2+Vv5fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QYT4nrEd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c05c30e0aaso178056685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739526518; x=1740131318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDr4jsMykS2/ggucs0AcLI/tKQzpn55xwyUNyvWALTY=;
        b=QYT4nrEdOPWxvCEE7dk0xSkC0VkmKFlVurzHzDGB8XaeZCciACCLQdg+xtXbPgj/My
         199RhFB16sD1A6q+SPkQ7t2UEnlf+qjxeiHQvi6qleDy7ptoPsMDPisxS/m0euzAh0qN
         UJ6WKSa0xmSunLQWF/EJjHMFQUJLnAIfw7rY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526518; x=1740131318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDr4jsMykS2/ggucs0AcLI/tKQzpn55xwyUNyvWALTY=;
        b=luPY3/LWyvtXtpBZJnEEO0PS203+9Gc23y0Bq7bzvSUYKJHv+DUBc+lV1Rr3xPSMx/
         +WFgviychhyU+z5boN8axWtWEey0rwzIeKuqwuQry4LPj9CcCp2OHK1XHFD2Zmt+MWT/
         /C8wwC2ATVzHiTlQMv+/zS7PuNxlMhlfyB0bejVWcTuuf5Q3TP/XsiClfGaB522JGXmq
         IbzIvk444v6eyFpS+BNHhopY5+c3mr+hlEH+39mxgWcId7uTUnpZROld7PftsuS1OspS
         nUOUO6Ozv7jAyQPBdB2IZjT82MiRG+zUftISxrPhSBcVs79fXrMHTbtk7AcY5udeiv6A
         F8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrGoHy4ryEAz0p2DB5C3SJpjjC2vUBsSf/9ABV09LH5zfQBRZko9h8EaU+rUQ4jXZh2zC7k6C+k3vZ4HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOZKF3UmYW897QxR351JgCX7X9KgADFI9uN0wkc1LJ2m/IT4E
	RWpMNmDzmv6rdJ5odXBqyji9UglBBuGdYm0nVYhBRZi0NmK7d3fkj8ejQu2lcwmRVLDf0kpsHon
	+CS79eTJB1GEd6Xx1xVKO2yRC0++f0OY5GQp37g==
X-Gm-Gg: ASbGncuxU4rRAIruiG8RI3MgIIgP35w00+cw1SURlg+76oIdp1HG/1I7SW3RxACLULi
	H1h5MuiDk7HOwyhC3rijITbS+HLuOFwxu478W8bNPYrSFNlkZPGCB6vFstdN2gCS91CAF55o=
X-Google-Smtp-Source: AGHT+IGuB62P59Ol+6vxloURqcamERa0qYdF0pLayov3aelu2QkTJBkViDqxaan7Awl6SY9eZnVYSryW0tCpG8J74gQ=
X-Received: by 2002:a05:622a:593:b0:461:22f0:4f83 with SMTP id
 d75a77b69052e-471afef5585mr160384561cf.43.1739526517753; Fri, 14 Feb 2025
 01:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207133502.24209-1-luis@igalia.com>
In-Reply-To: <20250207133502.24209-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Feb 2025 10:48:27 +0100
X-Gm-Features: AWEUYZnbRxMitMiVBkeyxPOZvfKFE0ntNolS4pNWHZK8u6Gg05D8SwmA8SFkAbc
Message-ID: <CAJfpegsymDHQj800wtD6Tq9fSOHjJ+UJ7dhvPf9Ut0LT71us4g@mail.gmail.com>
Subject: Re: [PATCH] fuse: removed unused function fuse_uring_create() from header
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 14:35, Luis Henriques <luis@igalia.com> wrote:
>
> Function fuse_uring_create() is used only from dev_uring.c and does not
> need to be exposed in the header file.  Furthermore, it has the wrong
> signature.
>
> While there, also remove the 'struct fuse_ring' forward declaration.

Applied, thanks.

Miklos

