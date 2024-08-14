Return-Path: <linux-kernel+bounces-285847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904A951361
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C00B21FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17041C73;
	Wed, 14 Aug 2024 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flW6rvB1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788023A28D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608621; cv=none; b=E4xXbJiC/ifi/xx/VO3tc9vfy2LM8/7kbDV0utPbq4oRc0IofFm7DC4U7chefYylDiCLTSzoemo70vbL+BtOc1H4StlqoYfoAscDbqhLyjwFOOrn3XXRr1HOknfwE5Ju/XMBVkgEG3Q7GP19cV+LzWmIxdcafBpKNT0MHAbS85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608621; c=relaxed/simple;
	bh=RipD44cWDMWQ+jXO625TvEblj6I0eqqeYpF2laH7znk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkZImAhmynPlPMfZVv6mKiBBlu9vtWZct9hR+nt0QWheVINSad9B6ktzFZvZtAG2QzufXl5IPLSUYK/sqk5gKImyHljAbD8Gekd2dUivBWBdJpZ+cvhhBmAoTm10PAF8Z3EaGE1pqjfXWo8gkqlFrWSwQGLnSdJIYBX8DxZrHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flW6rvB1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so666358866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723608618; x=1724213418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISPW+Qx+7bzTu2MxU1tIs/xLNXoLPqwd8ac6oJ+C4UM=;
        b=flW6rvB1rXyDPD65ns1Lol8wH4GAXCI4iCiCVleBZFKeD6baqnhCz17+Hho4Rv/WaS
         /fw1vBJssz6H1/vODUdVAWc5A4H7U+wFfPdaBc1w2LK+yI+z4g+3eGJeqbzB6REcYsDv
         kCvLa4A7QPdxs6WoH73aFHVO+E0P5wrqbZ/l0cbEVkkAI1dfL2cDg8AXffy2zNqa402T
         5OYY9hWktfsZbiwVfA/MCTyzn0yqfFtuSb0e/GI8RoQZQJ4CphuooBtlZTE+6ZPdblWL
         Q78BJ49cCN3llTlQV+PPhqbvzLggI476+WHyMKfu52cJHXOnvcC3HrR3I1haxjWVMHRs
         fCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723608618; x=1724213418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISPW+Qx+7bzTu2MxU1tIs/xLNXoLPqwd8ac6oJ+C4UM=;
        b=f1oL9m6iiwzGSGrM019Ohzbt9hKgiHkIwft77Q25JXJ5JX1liqqsWmI+GTBdlVk+aM
         6FTQ8EfBp8R3kVktvp3R4gRtM/LCPdnB3Rb+WHes+BRmsAnpaDWmQX5RI1LuPQbG9DXo
         Gssi0THOL0UCHO92usj1tzpReeh//Ow9gCUCN59i166O/7O0M0TTCYs5htLcDarKrnYy
         4FpupKThrZkQKepgL9ghGWH9bgWqrCsVoyhRkxnHIZbx8elB0Cgux986hgi9APUr1mnv
         Nkj+bjGdASKZBKzhFSL9Ykl6rIdCHXusYcxOXZKbu1SAJRy6Urh+6aVYIjCA+XhvLujK
         Q49w==
X-Forwarded-Encrypted: i=1; AJvYcCVVGFnl6fBoI8wgtMSj9a9WAv44bvBZooIGvFr3eWbJddUM+Tg2VbnpPoMcpAQCmHpPpRaxofq26+XBZwIEGv8WOCP6ASLLTHBcymoe
X-Gm-Message-State: AOJu0Yy44Q0cuds/9s1zElbImK7TbsCTzzYieHUuUwGztBr82EX0URjd
	HyfmKYXiEeM2Jf5m42mJnzfxR5p027/VNj0u3fnB6IdvM/Efdjc1WDsZyqjj5Lv2rCEKsB/hbC9
	z6JL4ptwINVrDXl82SPD9YmWbL14=
X-Google-Smtp-Source: AGHT+IGXnhXCugXZDWzTqqMcz2DmSHRI/XgexLfnEYCPoZj0QeDS1y/Gs2zevf9iRLZ1IZe2xv1pmV+KQD4StPMk76M=
X-Received: by 2002:a17:906:c152:b0:a77:cdaa:88ab with SMTP id
 a640c23a62f3a-a8366c2fa92mr80675466b.15.1723608617270; Tue, 13 Aug 2024
 21:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407301049.5051dc19-oliver.sang@intel.com> <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com> <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com> <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com> <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
 <817150f2-abf7-430f-9973-540bd6cdd26f@intel.com> <CAGudoHG1=p0GEVaSASA1C+iVYbfA5rryozAPPEoxr5uKtM=ghw@mail.gmail.com>
 <f4ddda8d-3513-4471-8609-acb3ce29219e@intel.com>
In-Reply-To: <f4ddda8d-3513-4471-8609-acb3ce29219e@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Aug 2024 06:10:04 +0200
Message-ID: <CAGudoHECfSYd7EcxiY+soh157m9H4xfU1en=TgX_=QkpbsOFdg@mail.gmail.com>
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9% regression
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: David Hildenbrand <david@redhat.com>, kernel test robot <oliver.sang@intel.com>, 
	Peter Xu <peterx@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org, 
	ying.huang@intel.com, feng.tang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 5:02=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> On 8/13/24 03:14, Mateusz Guzik wrote:
> > would you mind benchmarking the change which merely force-inlines _comp=
und_page?
> >
> > https://lore.kernel.org/linux-mm/66c4fcc5-47f6-438c-a73a-3af6e19c3200@r=
edhat.com/
> This change can resolve the regression also:

Great, thanks.

David, I guess this means it would be fine to inline the entire thing
at least from this bench standpoint. Given that this is your idea I
guess you should do the needful(tm)? :)

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/testtime/test/cpuf=
req_governor/debug-setup:
>
> lkp-icl-2sp8/stress-ng/debian-12-x86_64-20240206.cgz/x86_64-rhel-8.3/gcc-=
12/100%/60s/clone/performance/yfw_test2
>
> commit:
>    9cb28da54643ad464c47585cd5866c30b0218e67  parent commit
>    c0bff412e67b781d761e330ff9578aa9ed2be79e  commit introduced regression
>    450b96d2c4f740152e03c6b79b484a10347b3ea9  the change proposed by David
>                                              in above link
>
> 9cb28da54643ad46 c0bff412e67b781d761e330ff95 450b96d2c4f740152e03c6b79b4
> ---------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \
>        2906            +3.5%       3007            +0.4%       2919
>    stress-ng.clone.microsecs_per_clone
>      562884            -2.9%     546575            -0.6%     559718
>    stress-ng.clone.ops
>        9295            -2.9%       9028            -0.5%       9248
>    stress-ng.clone.ops_per_sec
>
>
>
> Regards
> Yin, Fengwei
>


--=20
Mateusz Guzik <mjguzik gmail.com>

