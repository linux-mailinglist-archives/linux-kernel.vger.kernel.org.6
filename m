Return-Path: <linux-kernel+bounces-178239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E998C4AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571791F2352B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFEE1878;
	Tue, 14 May 2024 01:31:03 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BF17CD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650262; cv=none; b=AaVFJ72SoomCSy3iBM9VfQPsHw77KtCg29PWB/xF+sgo0aQjVCdbmDQv+F3yHRZGshmszgwo8HAmYaIkovjOoAfR0sTH5u0P3SE+LbdegfZ+a9UAhqcVwvGlPFqJr45r5EJK4Dh1Re/HuewEFhgbwZK2w2uUccVCZQngVQABxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650262; c=relaxed/simple;
	bh=PkFgJ89WUniXWqIVEtu3YJ8YzVyfMts96HVQX+DQ7lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OitLU0om5JeBPT5MqyAaqk+K409A5/Fita+opQAGgaT4MZWpp0MMhSUPOT+W/a6acHkLL3AKuqE5y6iqDFOs7UlCBd+1fsnuAhbLaX8q7xd1GQMmpwC37wflv27y8QklEU0ymXTC5Ea6Ji5OZkKCcyJ72RyI1I7gValRq8ED9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e18adf7268so250172339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715650260; x=1716255060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgjMOM6qZvYmDEeKXBhlEWhKU1XU1fheyT5NoJUbfSQ=;
        b=KE91xHlq+gnSpSp9+/dfTSGCCcUJvZzeCA4ZawlgqAasAanI6Iu9lgv70gUyvnvQPd
         l1iw5VDCN/4++BnKaNES9PZF12dUEA/GYGMWS2pyN6hyx9UzbiP9M8tMXH6SKEmylYtQ
         OqeWADjJTZNrd7K9en/ngW9byUtQfqpqHEAbmjiFTO/2SqVQWTA9VvaCGGuOvqEmeZqz
         c6yCR4eslr5IHa7lnkzbBzVpz01DCKhfBvALvWB+QWtj00O4kmirW+Jp0eJTWJpYM+mb
         6B2NhJiuf9Pfi/WxalPX0lVnlCgSOqYuLq8qHZEO3tr9dIWG4cYhSdGhJNyFo6bp568V
         YpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFvIPqwefX/J9z94uvTyU7fVPLO9zbo9FO1oMoS4gUue3sRTuA2qXon9J3cB5NtLqabRaaSw+18Cl9s+h1kAoAlkYH1wt3taa36l5I
X-Gm-Message-State: AOJu0Yw5IZd8BtKY0VByTr1TO7VpGvYvJ6D61ZKYB3ee5yXp4fXOdC8B
	8ogleyvt2kbpY7T8aG4QmzcuMw3dFc27O32E3Ce5FWPJAxkrKy1C
X-Google-Smtp-Source: AGHT+IFVAJZEeF/a8/EofJUhAXh8sOZXQlddPPfhwtyQ7oVztGlLNGFxsQHhNYa9g7T4Qb/Y/WtVDA==
X-Received: by 2002:a5e:cb42:0:b0:7e1:7e89:f6ee with SMTP id ca18e2360f4ac-7e1b501f73dmr1261879039f.0.1715650260513;
        Mon, 13 May 2024 18:31:00 -0700 (PDT)
Received: from snowbird (c-24-118-59-230.hsd1.mn.comcast.net. [24.118.59.230])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893703bfd8sm2825328173.47.2024.05.13.18.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 18:31:00 -0700 (PDT)
Date: Mon, 13 May 2024 18:30:57 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: akpm@linux-foundation.org, cl@linux.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tj@kernel.org
Subject: Re: [PATCH] percpu: simplify the logic of pcpu_alloc_first_chunk()
Message-ID: <ZkK-0Ykapl6jxG75@snowbird>
References: <ZiiUoC5NokdpvDgN@snowbird>
 <20240514012500.248851-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514012500.248851-1-ytcoode@gmail.com>

Hi Yuntao,

On Tue, May 14, 2024 at 09:25:00AM +0800, Yuntao Wang wrote:
> Hi Dennis,
> 
> Can this v2 version of the patch be merged? Or what else do I need to do?
> 
> Thanks,
> Yuntao

I'm going to massage it just a little bit to format a bit more like the
rest of percpu.c. If it's a little too much, I'll send out a v3 and keep
you as the author, then apply it to for-6.10.

Thanks,
Dennis

