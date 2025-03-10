Return-Path: <linux-kernel+bounces-555278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8379A5AFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32C816D8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D32222B4;
	Mon, 10 Mar 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEDValuS"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7885208990
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650804; cv=none; b=qjD4X+C8m+K7hWCcpq+hg5HFMS3kCDG+hYTmqesmCG7KetU+0B5YJ5GTKZNULcKsrjXwIoESdYeO5+BjcmfOlTR+hXG5zRWJYfUcnf5TCZITF+HLz55b/cmTg6KvO44h30yv4rhSb8Z+6q+EdD2TKZxKAs39PiqMhQhoqHzHmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650804; c=relaxed/simple;
	bh=dhcwMF6X3nvf8UEcOSza5hPDNM+MPbmi5Xd5VNsSj48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r78OyY8gpD4HuIneI93bPHKvUTMFyMQDHfu5PSK6DrzFsnyKCzhRcvgQ426Rj122n0UVaZhfc+j8ZciUGWSRwZlcQoT7BneTIeXo/Huc29mOZiIDzTF06d9zBKCscPirzrdNLyYSQBmAVKz0j6ypoLXdg7Jsactq3OKc1CaS4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEDValuS; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so1920018241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741650801; x=1742255601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6Y4VzNyWkDTtPrsl1+g95pruVuPhFMc80PbfeZX/VI=;
        b=WEDValuShqFv/7C6aYKsWRZi4axm16amlg49+cfJ7+HuDi9J7gMr22esE1fxjUiaTe
         MGQg9mo7rbM2t8CXrJqCcq7WjB0iNKeGIZnxsM22Mcyrbe8dF4og4XyzflVg3fENAdaA
         8UjYZm6RfrtvIPUhyyigJveM5bQ+nmZkthT0xegYkTJDM7xf0CAy0TsW/s+eYqvlIjiR
         eVSC7gscK3Z1LOnWX9L/g7zlpMrL36KVTWy/4QvvuDznMlYwXXlcGkX+P+gbj25hGZuz
         9ss2G+lw4ePhywjklJVb2N/Xd1INCyxWnPTgywUhF8BO4toyRkOeRByatrJzszOGmrc/
         GcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650801; x=1742255601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6Y4VzNyWkDTtPrsl1+g95pruVuPhFMc80PbfeZX/VI=;
        b=KigZuXKUBBLo7L/a0u4tp7TZPHHI5ncQAQnpXSz5WpokRc6XGo7pgpS6rGMoG+JfAO
         pFXzr6+g3mVjUiofqvjKeoPcbzsMVXS5r6M2Ei+/fCvnJD3oDq93BpEEmOlxK+Zz78Q1
         sWTm006hIAyCWfVSuzbOu9JfwTqif2bqThXJre0Lc0l1XMjG+LcnkyycggoLZ7JVPVq4
         0F5HImJvz9I+uaaYJtK9BukcKFosPGl+4eYtDWwNq3JNMRyiZEm8Z2d69Cv0+EsujUN4
         AaHBuc+eJYJzXcFd82RMgwdKlFJtv0U6PNoI3hjNG11jcmb5hpp89xQFAEAQj2iPKrFz
         /w8w==
X-Forwarded-Encrypted: i=1; AJvYcCXTr02X1kbzZBsvC0u1sYTC2VWzKoH2WMyGF9mxP7DLM0mtKGKuMVhIwmb0jS2APgprw+cD503wwTh6O8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVWfLCk/adsoLkkjiEN9nbylxhjHHmEkB3Zb9XdwAu/2bq9M/
	8eOX3isn42ggpoOFior2QkYKR6ZcS8Drpwo5bBO514y0ywnv72qDdpUNndRe1qRXmVjy7Lqxkms
	zTHtYe03Gyw3/LcgokTG+Z8xvRbI=
X-Gm-Gg: ASbGnctHIfaO8Tr0H0b4FBC8KbnfM2fBjn8bRlnX2ZqtGpw3Mcwdho3SjHx70ZevWFY
	k2LDbHUkQiL+CImG3RncX+5EUqpYLVorP+sK3fG7drB7I40YSSD04/w0lFYXzwC2hQ3n2GICGR5
	nf+tS5hHzJv5HQh9FX4/nUSqb9xg==
X-Google-Smtp-Source: AGHT+IF4/yDyo6TLJ9hJS+a+RRSwK6hyoUZWcyCi2BYSbwy6U8YXx/VUkWN63EOCaO1Ec5zMc5o7TD4Yd3O7SgJHOKs=
X-Received: by 2002:a05:6102:54a8:b0:4bb:d062:43e with SMTP id
 ada2fe7eead31-4c34d036959mr1754332137.0.1741650801597; Mon, 10 Mar 2025
 16:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220052027.58847-1-byungchul@sk.com> <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com> <67cf7499597e9_1198729450@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67cf7499597e9_1198729450@dwillia2-xfh.jf.intel.com.notmuch>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Mar 2025 12:53:10 +1300
X-Gm-Features: AQ5f1JruGsm2bNY0LaoMU3hxP5sDYybmDIHSNsXhSSzNsruSbr_1xg3IZi4k6gM
Message-ID: <CAGsJ_4xK4ZydT5qqW9jnZ=Sw0ERP61RyHQ5wt1N8QeHJEK=s6g@mail.gmail.com>
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
To: Dan Williams <dan.j.williams@intel.com>
Cc: Hillf Danton <hdanton@sina.com>, Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, conduct@kernel.org, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:24=E2=80=AFPM Dan Williams <dan.j.williams@intel=
.com> wrote:
>
> Hillf Danton wrote:
> > On Thu, 20 Feb 2025 20:09:35 +0900 Byungchul Park wrote:
> > > On Thu, Feb 20, 2025 at 06:32:22PM +0800, Hillf Danton wrote:
> > > > On Thu, 20 Feb 2025 14:20:01 +0900 Byungchul Park <byungchul@sk.com=
>
> [..]
>
> Hillf,
>
> The Code of Conduct Committee received reports about your conduct in
> this email discussion.
>
> Link to email where the violation took place:
>
> https://lore.kernel.org/lkml/20250220114920.2383-1-hdanton@sina.com/
>
> Our community works on trust and respect and has agreed to abide by the
> Code of Conduct:
>
> Reference: https://docs.kernel.org/process/code-of-conduct.html
>
> The Code of Conduct Committee has determined that your written abuse
> of another community member required action on your part to repair the
> damage to the individual and the community. You took insufficient action
> to restore the community's faith in having otherwise productive technical
> discussions without the fear of personal attacks.
>
> Following the Code of Conduct Interpretation process the TAB has
> approved the following recommendation:
>
> -- Restrict Hillf Danton's participation in the kernel development
>    process for 3 months.
>
>        - Scope: Ban Hillf Danton from Linux kernel mailing lists for a
>          period of 3 months.

Please ban this guy for another 3 months, as I have another case here[1].
This kind of random and insane personal attack is unacceptable.

[1] https://lore.kernel.org/all/20250309010541.3152-1-hdanton@sina.com/#t

>

Thanks
Barry

