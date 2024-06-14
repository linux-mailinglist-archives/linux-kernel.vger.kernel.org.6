Return-Path: <linux-kernel+bounces-215479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3590935B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198781F227F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF631487F4;
	Fri, 14 Jun 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUxgS1hl"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6A60DFA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396718; cv=none; b=QCsi0zFRRwwASEglBgGBHorUFsNxLuO02bc+GCiQ7hJ04U3+aqkUeoJIzw7kPuMVUNBAXtjh5LmGOeqBokA+Vj4VBPPWFovqgPb/L+O+GkHwFzuLto99i8mS3eeDnKLiMOgwKACpCODX8IVp+eMsLSp65K+m6hOwK9zgfpHf70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396718; c=relaxed/simple;
	bh=axdjSQ1Zu5/EILmUtDEnQjyhEPcv2TO9jZPPXchqyvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgauym1Ib0gKlnv3R+BHymp2N5vSe5x/inRddcIom46MtXF63NgoG2wvYq/eRUP84mbKaZYnHYwjqnOuh6DnWlLY/HqPput8dDPd9cR5Y/S/ozeJMdFo0c1rWZ5ofzhnOm8waV9WfPyfloPzkqeTS3Cf8flryJBltXvC4e+ULl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUxgS1hl; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff06b3f413so2391981276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718396716; x=1719001516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axdjSQ1Zu5/EILmUtDEnQjyhEPcv2TO9jZPPXchqyvA=;
        b=fUxgS1hlxPNRgG5GTvK3WNMpxGcNHURl0616K48XuWX+CtwtmrjgjhMT9ap2pRgEot
         jh7kBgyNhf38dDziz6YO1CSkmDOIaEj1GXc6AgD5xfN1NFSnFTX2ZnekTG4g+EVCIG9h
         OIB8KHFXkPe9ZITJ+lGkUdMXrAVKIzYsedqz9h1q64L9l59N8/6cQerbwRSrQAmHyIRv
         johNLfFt6ZB5SuUqfj1PwyNCVEun0+k4+zwM9hT0tzc4CD/iuE+OXMBwW39w49kO5RCO
         e5nAQkwU9dvegBjnxC7D/aU4YzMxSlGVA8NlpspJf7zOwxnvNYwpM/lh10LpeIYoaI82
         +TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718396716; x=1719001516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axdjSQ1Zu5/EILmUtDEnQjyhEPcv2TO9jZPPXchqyvA=;
        b=laLMs+mTRz5LYOaDLdDfn5BexNwRbdgTrK5v7m3KM3zFDQQSx96RfBDi6lXPdsHJgM
         vE3NNsoYmNl8ewnXlIpVunNrh8AGQ0OYDkNk+hNdb6hJ6TQ5LwqhkkSkMI2QBzZHdd6c
         cS64QMKyeN2ZeE1NOUmbSaxTNsNpqlq0pqCCJuDFXJEGKuDIXbkp/ZJujqplRrxvdr+W
         LuFI9EUCJ64RWgRi8O9teajYLU9up+YIc/NmxBltSfHhj3GJ/SfWXBG1023Nffc5no8b
         QrAi2CzYNqO9PuONSvf+4FOG0SYLMrBGZninssS39mea3T4x2tnQvK2Fc6wYPG6QyYKQ
         pn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXItd4ixB0ULljvz4RYADsARm5SCZ8Nih4zCRtGzUKEHXpWqjnU9qKjaYeLVwliAetZ+mvjhYdPLxfStYcbGGG4bfQnvcxyg+2QvCs6
X-Gm-Message-State: AOJu0YyTOC3XnkxZzxAXW1XoFh9UBRg73N4tEsvbH55JfZ4NxGlQlCz5
	wuIEkH6Ny129Xul9Qi7XZXXpb+e/3TWGIaH/aPVGlp369oHkQitrtxtoWxkPiRCdpD8CqV6YfAP
	UXA+OziLB4AQMYM+K9d74xmY7BFNQBg==
X-Google-Smtp-Source: AGHT+IF5bWN9+eY2hIDkgu4ftLzJGI/Ah+wbUOVd528kWaq3VpHpLrmx6VFVBQSGo3TKJ1KBAXAZEMYHaVdbMqVirLM=
X-Received: by 2002:a25:ce4c:0:b0:dfa:c779:2404 with SMTP id
 3f1490d57ef6-dff153dbb88mr3765848276.30.1718396716173; Fri, 14 Jun 2024
 13:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100902.3469724-1-usamaarif642@gmail.com> <20240614100902.3469724-3-usamaarif642@gmail.com>
In-Reply-To: <20240614100902.3469724-3-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 14 Jun 2024 13:25:05 -0700
Message-ID: <CAKEwX=NG1kj7oaz08OYoM8Xt1K1Jrg4bgYJozQZ1JXbVC-=vWg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: remove code to handle same filled pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:09=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> With an earlier commit to handle zero-filled pages in swap directly,
> and with only 1% of the same-filled pages being non-zero, zswap no
> longer needs to handle same-filled pages and can just work on compressed
> pages.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---

Other than my previous comments to re-add the stat counter somehow
(which will probably helps with testing in the future), this series
LGTM!

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

