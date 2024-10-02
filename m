Return-Path: <linux-kernel+bounces-348067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D8398E222
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70785B23298
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97101D1F5E;
	Wed,  2 Oct 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhXVMqrU"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263D1D1F4A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892818; cv=none; b=Ou054pnkuaDJKCZ8IW5LjLxezbJL7uaMl4Ig4eFnOEojrQFVoEMqKhjwCXxq5Qn9/qcsVKdfSu+96YJCw22QFb3U6MbtJJ2bBvZcpWwyumZtH8OTXaklhgntx8nbOhezVWa1bwJrLCS7W0lstt5A+1wXHPbo4kMfa7ySg0ZoW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892818; c=relaxed/simple;
	bh=pPyGyZnHIjQkHGJR+HjvpOdK2pQI7HS2rxjykaIN3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba+r8DO8wD0oGdMJVUdTJV5V440/I1T/usiCsSfqsY3/eM8tVu0H0IQv3uxlLKmFVYL7r1Inq0qNocT77yxZO+RB2GOj4ilLmsDTOsLOBdHYzUgMWZ2oMZEq63zd2Wl/H+w2O6k1Zka1+P2zPZ+5hdmeQG3RoFQb8Zmh6ilN5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhXVMqrU; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb4c013b78so1094166d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727892816; x=1728497616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAGkFFTg5EfGgoSuE7ZBlpykp33ASSRnM9qMmo+v4WQ=;
        b=QhXVMqrUhZvUyYVdXfz6qMHN7heRzszU24leeHhNGXpHuS2Z8/zhEDpP9hRG/HiS8W
         XdRmTDYwMioEFnGXLheM1Le+OBfMd7wDMR0CQ/hAk3yatlffI/3JOuFf7SwMCn0hB3Zw
         qjdr6x8WYE9fy4Vmahfujdc7cZeu+sdRKAwXnG7sKIGM9PcgcoZc3UT3g/n6YHBQe7R2
         qmAaTr5Ve2T5GwMeQmTr4nhe719g1VDPIhcCccjiRarR4QT4l6LZCyRlicfy3yL1QJym
         hG4N87ECYKNcaO+oKwygP3ORTYX1Np2fDA+wIDPyra55ArEjdwWdASlJFkA0eoD0E7Rq
         6W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892816; x=1728497616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAGkFFTg5EfGgoSuE7ZBlpykp33ASSRnM9qMmo+v4WQ=;
        b=gflx5EufSmOklRoHEpk3HKGVdgujwiyHyXkyCHVCpdBPaPAZ/vXYjq6XdjCUH7CpER
         8fTUpaBxZNlINKQSYo/6bkmSABvXVInZYYkzlq1GShso27langYHKDxq1ZqHk0LP3to/
         uLH+TsZT/a2WiMg77O6Vk+QPinnDh4N22JfOsaNtEU8s/tVDRQndxOvd01qA04c66mxH
         rR6iuaNaGQvH09/nnuUCot5vY3zkirC6ezKQZsHfpFj7FPIjNF9OZWFU15Z9Vz+PYoKF
         F1JZQmbo2QQQSxaP/KzuGxVOUrGgufZL9ENPnaTwwPWJMiVn6HrWwcO0dorClVQohxA2
         Hk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhp63pURKHVLT0lC9LziO9CWFGk6O2UMcRDlOIXuUdPbAzfuvODabAmFgzaHQkWj5rrZzJyBTu5dkuyjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14nbLdzymqZrIH2SNuNmmM6HjkrPNrHpHBfNJyhLiGruxQGQt
	AkgLczT2SBkTurTacKMp9oo4vQatuEUtU0rtn7KztyNqaKt0bSXt7Qm24J6K0mr4KRNFqcG/VMU
	wXpbqwOi1E8fzvGPPN92R0Wcc6MM=
X-Google-Smtp-Source: AGHT+IE1XNmyIN/ZqJpQ/w+Za+3xNU+VQH2YDh/ok4cwVLPjCUr8odvRSRAJuA5J4VUWqyoKe3XF21MoS5kMSfv1EDs=
X-Received: by 2002:a05:6214:3c89:b0:6cb:50a0:1bf with SMTP id
 6a1803df08f44-6cb81a09239mr60774546d6.22.1727892815621; Wed, 02 Oct 2024
 11:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410021530.DnNbPqfN-lkp@intel.com>
In-Reply-To: <202410021530.DnNbPqfN-lkp@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Oct 2024 11:13:24 -0700
Message-ID: <CAKEwX=Ma9usQBge8uKvin=+GsuRDgJrDYTthzLg7zhtbLMPc8w@mail.gmail.com>
Subject: Re: mm/zswap.c:744:52: error: 'struct zswap_lruvec_state' has no
 member named 'nr_disk_swapins'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 1:01=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> commit: e31c38e037621c445bb4393fd77e0a76e6e0899a zswap: implement a secon=
d chance algorithm for dynamic zswap shrinker
> date:   4 weeks ago
> config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/=
archive/20241002/202410021530.DnNbPqfN-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241002/202410021530.DnNbPqfN-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410021530.DnNbPqfN-lkp=
@intel.com/
>

I'm stumped...I downloaded this config file, and used the same
reproducer build commands, and it built successfully for me :(

Fellow zswappers, anyone managed to reproduce this? Or is this a false
positive...

