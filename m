Return-Path: <linux-kernel+bounces-380498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19249AEFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FDD1F238F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B92003DF;
	Thu, 24 Oct 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gPzXB/Cj"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99282B658
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794323; cv=none; b=ZK4Tokw9txsUiF6k0z0EmSKLuytMWk8jNEKJVHajJT5juZFokx6e+u5H+w3hMMHpN744P05YxX1ipBGFaQmiXGQNoXJi5JUWppFd//Y0KN7Z/SHI8S+X97o2wjmhEJ8rW0mWcrgq37DYlZraXliaER2VeGmSTN8dAD+0KyEUygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794323; c=relaxed/simple;
	bh=THOqL+d1TZl4PVDh3DxDVyzLnQklVdVLrwXBZ3sQwk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQ9Ikbe2mr8iS8vgM2R5HrckXGOrm01jsmN7iCE51lMovDNnz9mdLfyNeJqf0v6WYsQqT3UZH6mQA/lpuEp1kgmPP+ggZtEVr5i8qvaqlPKSqzZlXfizFocExsAm2WfHEtSK57e7QmVt8CqlK6NPESJD9EWbkOC9hWZ4rmNfGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gPzXB/Cj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso19871541fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729794318; x=1730399118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2khBJsng+lMfA1RigqXF9i/RT/dqPLhoFo1OoVIZF4=;
        b=gPzXB/Cj9WGGQtGlwQ/1BghnXdun1CaapRzBzChpVIG4ljFtgPBNW9QJrOmS/zpsmy
         JvQr1E/RJTFVgvtMv4YBiiRJcyLuida+3c+Ab/eGAXiTC2UtcVTFl66vSfGBkXR57Yge
         JpfrzDEs5FuQSllTmcyAJGQpyo+jpoiBQafn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794318; x=1730399118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2khBJsng+lMfA1RigqXF9i/RT/dqPLhoFo1OoVIZF4=;
        b=j+Ed0oE6Wu+/pdWC0Ti8/8wf1t2/lvHcJdT3LmKvYWJJQppMeaW+PeP50s0NEA0Awx
         7VVxCSXQmhd1QGlLJIFUr9ssojdkS1SLz5wLkC9CE5HkGHbTuTrg7oxt9SnSAsBcJAKp
         /l1EW6cwJFyZuHhvyu/EhnKnmWbuTD1N4+AGtZNYkIu6Ia2BCOM9cQlorAnPQQM8wMw3
         s1Zj5ri/ybXo2GciUN3a+oyTGZLHWGuncrrpHo1w89f0IkIwfoUvLqwLJv0gfDppGQjk
         LMUtKTuAZb3IPWVz9c+M1vcbv3ADaEjY0CbQPc1BoeUIvtyxy7K5LcGUx7/0G/DU8Etm
         5WGA==
X-Forwarded-Encrypted: i=1; AJvYcCURC1o2eyMNvMUt3lsYqczX4OxD7Ifsx0lJ8XcoyNFQonTd60dlgBMSaUZ/Up1iif7qJayfLW0xRu6MSLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5pOusj+nxVDSe1Wwl1vBQqwSgk2y/5k/0wx0wMBGFb/kIXLT
	sr6nLWEpoLiVepvdJsJ+uWx5plDkpXq03Dux5CKdlV4qdXA/tAzZfDqpfIYopoA8h5Zm/UMucJp
	Jymt57A==
X-Google-Smtp-Source: AGHT+IFMXVHlbPj8utMTiJQABozXOI0wVQM6JMqiddLOa0HspN1y4ePLGMHyrTIjVxJSvPYht1KdIg==
X-Received: by 2002:a05:6512:689:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53b1a3ac075mr6715530e87.52.1729794318116;
        Thu, 24 Oct 2024 11:25:18 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223efbabsm1438998e87.103.2024.10.24.11.25.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 11:25:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so2091638e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:25:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZrdsDT4sdbIRMwVISqON0IhPuaUYGEtBd7Lrna+wGTnx+fvn09LVGbNdZ8SekUspWqUwjF+B8k/0XfiU=@vger.kernel.org
X-Received: by 2002:a05:6512:3b07:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53b1a328288mr7321722e87.16.1729794317051; Thu, 24 Oct 2024
 11:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org> <CAEf4BzY_j9e3Awqn-mOmHOy4+SWn752mXX+mySQYdKoEHr2RPg@mail.gmail.com>
In-Reply-To: <CAEf4BzY_j9e3Awqn-mOmHOy4+SWn752mXX+mySQYdKoEHr2RPg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 11:25:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtTofbM7_D0GAFJL6j3cCLeBAkmTWGkwAB6U_VjcE8EA@mail.gmail.com>
Message-ID: <CAHk-=wjtTofbM7_D0GAFJL6j3cCLeBAkmTWGkwAB6U_VjcE8EA@mail.gmail.com>
Subject: Re: [PATCH] Revert "9p: Enable multipage folios"
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Howells <dhowells@redhat.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 10:58, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> +cc Linus, in case he decides the revert is necessary and wants to
> apply it directly

Ack. Applied directly. Thanks,

                 Linus

