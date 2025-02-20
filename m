Return-Path: <linux-kernel+bounces-524483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D6A3E3AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075947006C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F76213E87;
	Thu, 20 Feb 2025 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVwonuJo"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE02116F4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075489; cv=none; b=TGwUT9IpIgHLb/yMuQFZQ8XVp3f4mQl2XGEYaMH2XW7Rhg2qsFanP0jVeRm7J43OeHZrSZ6UWjlfwUMOa19ZahKQSHi4YmHxUJn7NPnafj+zep8KB/iMVFbxfKxnTszUECFCZF8HWxVP0+qR2sCXZVFfnS4NavPF5HaUXCYVk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075489; c=relaxed/simple;
	bh=Ykt3z+cEEEUsIKeg+bYmHLyQJ1eX8o9zkXfDLy9xi4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StlvZoRULpmkFNsakY90BQqKtnT2pmAajt/vPargzkLUHKnHUkKXQ0TLmR+M/FfdCHxWSBt0C2iMfGY8+qgXLfYShQc8ve35uZehJyMsJWXmZeHAgxxcN40JiAv2xEYcdEe+mtcmugcaLBfpxiL5prWTvKtZoWX2Ui3jkTm6Lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVwonuJo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fbfe8b89so30831cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740075487; x=1740680287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+KcVTRVHEtJrwbwtXf+hP2qsL5SaK8Xz4Fd7FX9DX0=;
        b=HVwonuJoc5zk9z2R+NwvzN1URXHr+Z9BlCg3fNP3pBBuLFUmh6TWKbWSbP7hScIVG4
         JjM8VTwog3bk1ahJr9xaLI82nfhKhjGrxVtXc9TSOeHzQgpScklD6WQctu/WimnFtuX2
         xrUcrGoK25mn66hqdPPVrzw9AZc1dcRzutnibV1eerF42YRP/eUk0YEeT19K9XboQTVq
         szGAFTnE4uXidt7sKCrhf+kRWr1UZWkohAtOnbbh2ljfczOkA2YGLjecoOsPY8OZDgFB
         FbppfhDn4NLvrTPuOLKhkl3QlZu7HkMvI+qugtLWO3grpadRzxVWHRY1qTc53U5FUCsR
         KQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075487; x=1740680287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+KcVTRVHEtJrwbwtXf+hP2qsL5SaK8Xz4Fd7FX9DX0=;
        b=Th4dyWIVNGc1QEoZ4MdbxnOqdZ6NMDdT9FcIrLBsmfqID/2wj6pfyQLab3pwyEkGso
         O9wzgZZAFXqCbJdBqwx98hrAmKax6QAIXdeYORHjvINOlZNCoNbSQ7/3yzUjQSAZY4Yz
         0sXeWCEgkPBUsHZyfjncm3b+Eprf8Lh1YEPoHKb0Ldf8oCxKWypo7uFHkMOXJhAgioBQ
         i+XHbkYE+VnJTX4EViAZ0NpbfupumFIwBdLIMqcBJdw0aV3vtUKb4eCfkyacXNcw/+Tc
         LqNaFPpKX8NLq2oJj9vBM+B5GVg9mTjXsBR5bxpBXTznjJ65bZvE4i1cBGM0kwhOGq0E
         pTsw==
X-Forwarded-Encrypted: i=1; AJvYcCXmhNUgsZUYOcabsenChEziQb5LBXEZ0NP9KJN6IoTsZUx8dXth3CIHqjzHil/aRYeR6cqcsFStTO+3tr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJwUXEdIiXkTt2IYZ3L5rKllJKSyaJVpgauKiEGGAlk0sdPi0
	F6lFOr+oZwjLjV6UX8gZuOKPFqezKc0MivKvJGqkY6YuknIAa6BmVTCK9jPiH08p7VaTQpp1G5h
	K2kC8giT5EWVNnk9q4Vnf3Kph0zi0YI7e9CQqe+U2ziU/7NdGYTqf
X-Gm-Gg: ASbGncun1pAK2958odqhKMLH9VpB4WLoccbw5/r+0NKDVLOLPbq+7LhIrlAA1gWU+bP
	x0aE9/YzhsbDEWBJzg7oCooa0G6UJ+4srWgmqC+8oPSvdfKzUH2H3VBESuD56kZDedvdBhGmRnF
	TCdaH569peVPCV5Ohy0+KAMQ/SvfU=
X-Google-Smtp-Source: AGHT+IEL5k884q3yjOFoRKHquFIJ4dYata9abh/OY1fVwIJ12uqEUW4ipXq+lx2nxS/e/ao3pYhy5FD44BVggxqW2v0=
X-Received: by 2002:a05:622a:190a:b0:471:fefc:f002 with SMTP id
 d75a77b69052e-4721710d98fmr3752251cf.9.1740075486265; Thu, 20 Feb 2025
 10:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-3-9bbf57d64463@google.com> <d22b6cec-0688-49a6-a42a-decb2632aa79@arm.com>
In-Reply-To: <d22b6cec-0688-49a6-a42a-decb2632aa79@arm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 19:17:54 +0100
X-Gm-Features: AWEUYZkLdjTDwhb1samESg0X1fNOHZohuSJyO6aDmg8HFaVJn5HoSpK5AKDxKuE
Message-ID: <CA+i-1C0terC2xjZBfzT+T7yFEp5LodZXWFhoP=Q+=+=urp6fGg@mail.gmail.com>
Subject: Re: [PATCH 3/6] selftests/mm: Skip uffd-stress if userfaultfd not available
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 19:06, Dev Jain <dev.jain@arm.com> wrote:
> > -     if (uffd_get_features(&features))
> > -             err("failed to get available features");
> > +     if (uffd_get_features(&features) && errno == ENOENT)
> > +             ksft_exit_skip("failed to get avialable features (%d)\n", errno);
> >
>
> s/avialable/available

Oh thanks. I thought I had codespell running automatically on my
diffs, I'll have to look at why that wasn't caught.

