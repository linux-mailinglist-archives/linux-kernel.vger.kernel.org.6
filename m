Return-Path: <linux-kernel+bounces-193199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE68D2833
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036401F25D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8F4437A;
	Tue, 28 May 2024 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weW/IfQD"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923317E8F3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936366; cv=none; b=Av9v864e42ubjpU7CjgIuj4QVmWvwmd3E412bl0lOEKRrYW+/UBxx2KsygRKps9v0QLxnirXWhI8H5Vq9uDsr4H6B9PeE7alo4sQBaicyK8PeP7fEd0j29hwyLDaVBOE+s0OlDY0h6uWoFauxr7S/xMwcbzhaf9ogfIh0n7wbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936366; c=relaxed/simple;
	bh=x3eO+xsLGvYH6hdnnKdPPHQw9PwgGh+IMJx8r3KsF7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKCwggcOe+dNL5zkMapUWHQhq5amE3eIc/1k4x/thSvkttpeuPjA+D3R4Vo42uazrHnj8dn3zzEMfzRxsXKH62c3NKO6oFq7K+/a5RYSjPm5+w6PCQLJbE7oZGKQfhkc4b3+FdKvBwA9mjRhUQ8nF7rHuzxOlsEVAZLudJ963Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weW/IfQD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a08b1a81bso13136007b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716936364; x=1717541164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3eO+xsLGvYH6hdnnKdPPHQw9PwgGh+IMJx8r3KsF7A=;
        b=weW/IfQD1s+dFJvVDhmmiKx356BZ1PmgxYYQpLMch8nyUAw3LhU6y3bKpc1MjgeEgI
         oY/iedTHWQTn4P35NJR0ZR/tMDhA3wEeU3ezSyzwyh68xcQ2NxMI6vNNTCmwkwoMq62d
         M+8U6uzATkTNqz+YfNBnpd8KFvoEl3B0Ukg65kknmByUQrG/IBOUyz1rpW4P0vEx6rsw
         2buwlLTAOT5p+6lbqt0E24YtQiBqce4siE9ZIlemuRglje5Y4dZufgdR1JkHNgNNEPAB
         GF4p8Tfd2NhhuUpQAAgyOHi3ZfCDA2ASb3z+joJUYEwhMoeRaty7uyelKerelnJXKlQe
         VVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716936364; x=1717541164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3eO+xsLGvYH6hdnnKdPPHQw9PwgGh+IMJx8r3KsF7A=;
        b=uO/FF6tcDGXovyAuMrYGrzLvlTKLND1GYaefphzEm8Md/MceMHY8ylkSPuBCtq2cPq
         ypX0Jt81iiQYtqE7I9BLF5dpf0GLOcy/bk1YL1EdqDojERnV/e5Fewu3+4VWTfoxUffG
         85u4VAh56cN27Z6iINw01uMv0/hGKE0Nxvea8tq/FGm2V/Rei8QPzv2grivxOZnuQcBY
         LTc4d+VWXDB5VW9DqFbQh+O6U/oZpQznKY4wuC8grVy+BtbvETYxtq6cdOfpCqjtO7Hg
         bvJAZVO4sr8gjW24xR8gWnvP+WTuu2cvcUIoTTE0mZYRpZuLeXsM8vYRaz4zlo3c+wmt
         Gkhw==
X-Forwarded-Encrypted: i=1; AJvYcCV1+wo9+gosjcx3okQ8ufIh9MIUSxJIijeOtLtZOLhlgDr53UBoPUSxEc+nWJasyzss5W7u63gWPlwVhWIVkKkbgv2qtXOBJIufvTrC
X-Gm-Message-State: AOJu0YxK8nXA+IcLoOJuuuMSx+xCDZCEaEHV3EKDv3u67yVSjY0I0FWC
	zt1EH3uA8Mfp3nVuRrgZDJM1BXf8/Be8zthz+li4r7sx5AkhUWQc9M+DWCk2piKzUWAqbRJOc3G
	4lIDP+7jcm+UCdCbKGq8n8o/0DhwaXnsVdZIo
X-Google-Smtp-Source: AGHT+IG3bkluE1gQLzQW/yXE5rXTcQ0ni1+AICIdU5G38blbecC6K/RPr2rHoicqTJdRS6GN/1aRMHyTcoQS1CrT868=
X-Received: by 2002:a81:6dd0:0:b0:627:dd68:7278 with SMTP id
 00721157ae682-62a08d86f59mr136358967b3.19.1716936364259; Tue, 28 May 2024
 15:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org> <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
 <CABdmKX2vmpFS=j_FoFOadHRVVWaWUsReJYv+dJNHosk1uE_Dvw@mail.gmail.com> <ZlZd2EsF7KOqPx7a@slm.duckdns.org>
In-Reply-To: <ZlZd2EsF7KOqPx7a@slm.duckdns.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 28 May 2024 15:45:52 -0700
Message-ID: <CABdmKX0+rRAHVDmv-A549OxBsyaLcTERYeM52_1ZhiL0-gvTyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:42=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, May 28, 2024 at 03:38:01PM -0700, T.J. Mercier wrote:
> > > > I think it would make sense to introduce something in a similar
> > > > fashion. Can't think of a good name off the top of my head but add =
a
> > > > cgroup. file which lists the controllers in the subtree along with =
the
> > > > number of css's.
> > >
> > > BTW, there is the 'debug' subsys that has (almost) exactly that:
> > > 'debug.csses' -- it's in v1 fashion though so it won't show hierarchi=
cal
> > > sums.
>
> Yeah, something like that but hierarchical and built into cgroup2 interfa=
ce.
> Would that work for your use case?
>
I think so, I'm checking this out now. debug as v1-only and non-stable
interface files doesn't work, but the same sort of thing with a stable
interface on v2 seems like it would.

> Thanks.
>
> --
> tejun

