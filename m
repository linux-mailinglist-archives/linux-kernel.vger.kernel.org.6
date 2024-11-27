Return-Path: <linux-kernel+bounces-423961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCB9DAEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33741281354
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1712036E9;
	Wed, 27 Nov 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZvyVUvCy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53F154BF5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741610; cv=none; b=gHwpv6A3MrDi0p5JCq3lWu9TzoisI9cjit9pH3YUT+63ei8b7sYx53euH3RlGOCiCizfQfEqWLjwTwInZVaavf+xgR5T1Z7fXiVNm/zfiMxwJv6joIebu7uRD1vxgbb5Qia5LVPnLdxsmw/WFcy7Nnp1wL3iZaaDlpojtsdOLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741610; c=relaxed/simple;
	bh=9WWaNqbNFx7zDSvFdbXOioyNmBGET1MdjUtI2sIrRLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY4Ocf1HQqDDSYt9Qbjg9rMW0CG2sfgBXB2YuaQ3cF0ZZILP8rwecylxnOQ1Ov2969itbek5MKbVgUpi8ZeJosms5A3hnQfO8EZettCTUryupyzhBS/bECXizWnvg6UptYD/tHVKQwG/0WKULt2mthJd4EQa7+J7t8mjkRpWF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZvyVUvCy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso126224e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732741606; x=1733346406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WWaNqbNFx7zDSvFdbXOioyNmBGET1MdjUtI2sIrRLM=;
        b=ZvyVUvCyVf6kirKb3rhxwODr4RUAQjy6v0cQ69J848UeJf38NxRkcwWaNxi5Dy1Dsy
         eGuYBuS4eGAoVEl5vJmyytxE56qqc6iVyuS93i78IQ+qFd/vfTYQ+EqVkjsHUKMPQAq0
         JqPyRucDdLMuvWCQAXoLi9i7tLiEjztYi/Qdp2MYXjYQdRlLOhEp4qo5MgiHdtwkjBHQ
         j+HQws1xq8sEWRg+d4l1qJH3oiZN2wNjOlXqPYgcXqc2qyMHHtWNki7DUq6hrsENQz4O
         ijDBcoqoDet6AnABiPwvnsceCxlY2YGjtYviiEHfHV8fYscCJyjkE5Bte/7LG/KeyZbA
         ojXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732741606; x=1733346406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WWaNqbNFx7zDSvFdbXOioyNmBGET1MdjUtI2sIrRLM=;
        b=liMf7A6EsDW+zZqAuRFQyN3tnOwGGHNE6c9lI9U4uENIn45dF6RYVSC12NKJnZI8j5
         A21uX94n+veP69o8OttTSk6318GYu+srLIfDDR08dYXmR7dlV2LKo1KQSeAwsgbOQXS/
         BoPAJffuBPmyJM/4SC8g+yuUaAsDj63pBK3uf4XbsLxLi3jg+aqWHwKmEAjEZ5tuL1un
         GCMl420bIdv46+dbgeJXn1b6NcPoe6S87qYG9aw6bNbJfAja2zv93veGI6tDvxRcY8WD
         34f1CWuijgXSQaxy/LS4euhNICrPABnuY+5GwON7ibZhS/7Em3XZTsCzD5oiXtH2fm5y
         A/PA==
X-Forwarded-Encrypted: i=1; AJvYcCUI1AU5oULrbmHlsDB4HQ+3AhEiLpTUxT+7QccYEp2Ohmk7O5BS3kKHV7GXMlGqrQ39zfYwj74V+VoyRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1rR7CZEvpaZ3MVEZirQvf/C2QKksY+mb23errAQdeSKW69Yj
	39R5LID8dMxH5akkQfWmK+aCKIiSN/8GI0XEpVjwVpEGuIwZSRCPA9WjCDZlF3p09NMzDV9SBrw
	dvyuh7UgmPEIo/OBw5vGgB3ahJGWhwHwAe8lxjg==
X-Gm-Gg: ASbGncux2PqmYkllZ5XAikqRQG7KXd4bw7txVhukHMRATCNrVAZJxvz+pApzkOPFOhD
	IkXzI5n/CS8XERLRsTwaWJUrBgINNepcxQ/w0iFRVNnG4jZuxamZL0sSVx0Ty
X-Google-Smtp-Source: AGHT+IEdbHnRzGwZXtI3+5F7LoiEkUxwBFWYttWOWC4DjMa0W7DfmxC5nfBt/ZmmQAYZY28q23O20T14kyLO/bmqvB4=
X-Received: by 2002:a05:6512:b18:b0:53d:ed6a:4db2 with SMTP id
 2adb3069b0e04-53df00a976amr2672808e87.11.1732741606079; Wed, 27 Nov 2024
 13:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165405.2676516-1-max.kellermann@ionos.com>
 <CAO8a2Sg35LyjnaQ56WjLXeJ39CHdh+OTTuTthKYONa3Qzej3dw@mail.gmail.com>
 <CAKPOu+8NWBpNnUOc9WFxokMRmQYcjPpr+SXfq7br2d7sUSMyUA@mail.gmail.com> <CAO8a2SiUL3T=MHcktWDaMbToqJYt7mYD_XN5G2nRAN0sxCHD7w@mail.gmail.com>
In-Reply-To: <CAO8a2SiUL3T=MHcktWDaMbToqJYt7mYD_XN5G2nRAN0sxCHD7w@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Nov 2024 22:06:35 +0100
Message-ID: <CAKPOu+9kdcjMf36bF3HAW4K8v0mHxXQX3_oQfGSshmXBKtS43A@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/file: fix buffer overflow in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:57=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> You are correct, that is why I'm testing a patch that deals with all
> cases where i_size < offset.

I don't like that patch because it looks complicated; it obscures the
problem and it runs a bunch of code (fscrypt, zero_page_vector) before
noticing the problem. My patch is simple and breaks the loop as soon
as the new size is known.

But I found a bug in my patch: I forgot to call
ceph_osdc_put_request(). And while looking at it, I found another
(old) leak bug. I'll post two new patches.

(I'm trying hard to suppress a rant about C, after fixing several
other Ceph leak bugs this week that caused server outages over here.)

