Return-Path: <linux-kernel+bounces-267890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F9B941961
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B381F2533E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C118990B;
	Tue, 30 Jul 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QnvKyE+P"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD7189513
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357100; cv=none; b=ZVxCojKZ/Tnq8UQFDPeafriBM72xkFYV7HkPqul+oy48cAGEkqiqzPDcNyZqH9UTZU8qKuW+JbADGbTuCeu1uTfG0A6GHmP2lzPh0MOYegz39jU+K3sIxYU0i3rknE06OTwrZ71xBl76N+ncZxIMm/tIUed+dutQCFObs4ItK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357100; c=relaxed/simple;
	bh=nyrerJDyhxrjVhddkZkyuAsVrv4YgfVF935QAWq/eAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzZnduQZL013mo92OWJDfLFaMnsUFA+ykQGjobpPFVUOz6VwBb7KViyUJ8BmC2pSNG7QBXqpAhyAvyk1a/1PtefkyXt3Hl4oFI+3PQuHXdEkq9O7KAf5YzqkotBIxAe/fIZqjJZH0Q/jWi+vH9S26K4/i5vwbY57swnxuiBuOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QnvKyE+P; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso627411666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722357097; x=1722961897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5cj6IhKT08G/JY9sA9ZAZBlaQGsxU+ED4GyGLcLHJ8=;
        b=QnvKyE+P7ei24VE0NqPYK3qsHjeemZi0qale+y13a3WGNC/yFv3GBiAmw0By4yXeLq
         chDpI2yu/44/lcwrtidEjFufcEWGYJlHMshTqSW9i6rgwXCrlWRB7w+MqhXKUCBB7Jc4
         ltl1mSZgefuYvaX2j2xHBm9uvuMmqtYKVN/AcQuFqfmKs6iHzP7NFfMf2vjcD8XRM5Yp
         9QnlC+TWA8R5mp46TPJvZpkYKEKcYXk2GSE5lyf3ICAG1tX6Rje3bqXUDzC1SmGjL4E3
         lAohMo5bN7gi1XmciGbR2jjmW2w2u5sKJJB2ilmSYAGdEWxazHWfKAyr95t+bDoTfTXn
         TERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357097; x=1722961897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5cj6IhKT08G/JY9sA9ZAZBlaQGsxU+ED4GyGLcLHJ8=;
        b=p/C2wObWVOEqoCWJGGPDS19EPKUjUOFBsNuPzQg7kgwc+S3/6Z1WLp5wLGa6e2FkY4
         n+weWMO6OFdWorLQGRzcree8Pad+XAiX9hHynPEr6WExlzNmhfLBe9MGRzwcKVtJgOCA
         2hgHOZLU2RF6rW1f7ZyURdwqsL9slAfrUQZF1pVAJiajL4Cvph940uUaXfdoikuc3b5h
         nVGE64R/uvGn7I9cNDv1Ls4gfSFQ7WzodRVjWvu/5uibGpTVFjhaUYOZ4D4r9177v4oZ
         yq+G8QyRWF7hEddp08sZekwaSmzCKHxSPUzN6qZ9Lw7QE95hbiXxBa9h/vIHYN/AD6Mq
         gPag==
X-Forwarded-Encrypted: i=1; AJvYcCU9Yp4ClZcA8Iqo9S6zLvchftL+OPnfXThH9OtI6luhTrV1fLpar5B9nbMsbFkpr2zXACaAcmxso5OVrVhS4RWL+3U71W+iXqCuDjOy
X-Gm-Message-State: AOJu0YxPnsRRA6Seu1lKXOra8nGOPdS4aQB5S6ythhgsfwph/pVI8AMu
	zuNMGo9kosnJ77wkIp+psZuQrtKzbhMzAYRF5wfww5aBswK3lH516YQehcpzqg8qDUnlQD8aSen
	iOoD7wLRFrS6/ah4XRq9yTA/2frH0I2mVPwRPEw==
X-Google-Smtp-Source: AGHT+IH7khnXrujEv1gKQnGzEfjEWyF4QEf2ukDbjiCueUR6RcV66FHsXp7NckoSkFnWoeFBMNqlnHILehdexStSq60=
X-Received: by 2002:a17:907:7284:b0:a77:dd1c:6273 with SMTP id
 a640c23a62f3a-a7d3ff7cb6fmr795199266b.12.1722357096904; Tue, 30 Jul 2024
 09:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729092828.857383-1-max.kellermann@ionos.com> <20240730-bogen-absuchen-8ab2d9ba0406@brauner>
In-Reply-To: <20240730-bogen-absuchen-8ab2d9ba0406@brauner>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 30 Jul 2024 18:31:26 +0200
Message-ID: <CAKPOu+9DPbtpDOtmLf=kSvK8Vw7OQfET4-Tn6bHAcXe90HFpKg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/netfs/fscache_io: remove the obsolete
 "using_pgpriv2" flag
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, jlayton@kernel.org, willy@infradead.org, 
	linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 2:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/1] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
>       https://git.kernel.org/vfs/vfs/c/f7244a2b1d4c

Hi Christian,

thanks, but this patch turned out to be bad; see
https://lore.kernel.org/linux-fsdevel/3575457.1722355300@warthog.procyon.or=
g.uk/
for a better candidate. I guess David will post it for merging soon.
Please revert mine.

Max

