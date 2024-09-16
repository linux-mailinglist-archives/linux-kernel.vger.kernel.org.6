Return-Path: <linux-kernel+bounces-330934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C290997A63C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CD21C25FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5815DBAB;
	Mon, 16 Sep 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Djk1CE1D"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF11581E0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505384; cv=none; b=YZWHLXw+zWRDSW8FTQIA5zGyl4iNaKpY46l39Vsx8YHYQpuM7O7gOgSuFRfLC3Snu+e3GeEnyUBwCr1GBCqd7Aezs7n6f7u4xB02E/CXE9BsAjNuIvwAod0QzNG0qn3FvMQf5DmwC7On+pfys5xVrcRxpf1SeMNp8z06jAgaSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505384; c=relaxed/simple;
	bh=JqVxmwm6imXSZQvq0ATGpozaXZh1gx5CUVR2s7f8Des=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjcq8pYFqhtQXNIquNfZyJBW7+r9XxG7sIImD17CBqg1GzCQ54f/832viE0QzNpPwX33pMtFDI3Uggc/2O7llsj4/rA+4Pz01ihhplKy9ngdJ+gx/5125CUOCPnJ+oQwyNUBikImXz0nxvkkA+wmlnsSNQjxFAP7EH7LXIIgex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Djk1CE1D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d64b27c45so575461966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726505380; x=1727110180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+b7ycIpbNYPDxRZFWGu5S2e+XILAOlCP4jNkvghsyI4=;
        b=Djk1CE1DDPFUPzbbDJrp/gMrFVkKLMS16s6+mH+u/dYeCQdaWioYtk4nkxyAOQSfsT
         Nq+UhZT99TKaALjNfqBRY6B6YrCcKRgZ9J3ffSHpip/FuQP5tRGJcOXcp21x4R8rNjdq
         ltyWcByxDLfNpnfmZZ3q7D6sMgHWBI99aNoHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505380; x=1727110180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b7ycIpbNYPDxRZFWGu5S2e+XILAOlCP4jNkvghsyI4=;
        b=ZL7rcE0tcRkm8CL1TPmERiSD+qlYzS9PxDdqrCeqqAClta5PgePQeC0nLyAjuWKRXf
         u3JXgfk6Uct+oWop4LeegowLb/TtKG4Pcb+eqDnKDlHYqA3w2IhCY0loLBacezHgpafV
         g4oJdURq2+QAUAVAyehaWkp+OL+EXDqCIwbOsOJuhiSqJvfg7FbaAuevx7lqdIJ3vcrE
         1mXPu7lg+O7jVKeeiNxvKGPOk8rCuIqvmFrS664OU+flwOilVDu8/pmaI8cO9YSnoQUH
         suMycfWAkAV2vEe1bZiWXBvR2IPqyISUoTwYFyYKmjnVaLOxzwkKxJa2aVl8qBBEI6Ww
         VeOA==
X-Forwarded-Encrypted: i=1; AJvYcCXPw4vK9ceOvQ0IlkOpBS8lXMd25kwrAPFb2f4tCzia6o6rw85A0A2lW+3l2cbThJzEMkonyFV5soj+W8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQgwshbg4Cpvp714OTqBCwkVE6sY7HSUezmglBTPaa+6DXcCm
	+yU/2e978G8WgHe86+hgX0k4/wCeS50/gSXhHZB88gQ9NufdQZhPFkp6V2O+LRZFXbEdU7bWMPd
	jNFZREQ==
X-Google-Smtp-Source: AGHT+IGVIV6IXfhfX5TlUPIjMjeETMILTDgok2bTfbTJHinZT7lpu8Zezr67GwFZfoKopcdkrRgb0Q==
X-Received: by 2002:a17:907:948f:b0:a8b:6ee7:ba17 with SMTP id a640c23a62f3a-a904814d805mr1405424966b.55.1726505379922;
        Mon, 16 Sep 2024 09:49:39 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613316c2sm335592666b.211.2024.09.16.09.49.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:49:39 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so4819420a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgSFdT6bzUyDweNDhpNUQAeIiYlP/qgFXtvL3mBScDt5ynBGW2kP5mh7cwEzYch4uXjhSn4rJATN/UUfo=@vger.kernel.org
X-Received: by 2002:a05:6402:50c8:b0:5c4:1325:70a7 with SMTP id
 4fb4d7f45d1cf-5c41d5b8c30mr13446851a12.0.1726505379030; Mon, 16 Sep 2024
 09:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-vfs-netfs-39ef6f974061@brauner> <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
 <1947793.1726494616@warthog.procyon.org.uk> <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
 <2003346.1726500810@warthog.procyon.org.uk>
In-Reply-To: <2003346.1726500810@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 18:49:22 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgZA6kgZSd_4rx=KsnxM8OU0+FOu3T9mJroBeHq2qVO=Q@mail.gmail.com>
Message-ID: <CAHk-=wgZA6kgZSd_4rx=KsnxM8OU0+FOu3T9mJroBeHq2qVO=Q@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix cifs readv callback merge resolution issue
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 17:33, David Howells <dhowells@redhat.com> wrote:
>
> It's probably a good idea, but there's also erofs, which also goes through
> cachefiles_read() with it's own async callback which complicates things a
> little.

So I was thinking that if cachefiles_read_complete() would just do the
->term_func() handling as a workqueue thing, that would make this all
go away...

           Linus

