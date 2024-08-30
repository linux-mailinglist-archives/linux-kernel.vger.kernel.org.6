Return-Path: <linux-kernel+bounces-308669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321696600D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9951F2854D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1B193085;
	Fri, 30 Aug 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OkhCL2nJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF903192D71
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015967; cv=none; b=Mp5AzPjm1habGK2EFxUj+JgIXDCCOoKyWlncuJ11AzARouX4DmIRaNJk1YkEVPxqMvZYkgD7S1RZB9NRftHHtukNpsW5PAPodpqD6wY6vBfaxssctaXLPBxFysD0EY1XZBOCT/66hQmhKOPAVekYgjxyIcMiI95ylkgcUZwgJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015967; c=relaxed/simple;
	bh=uLRBUAGTT1dp8YZ6wtLJ8pEaA9JfqlHSICbT6J78HDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6m6kWYnZIZL+RDXPSgOkGsVpA7EmfRFYNaBC1IvSHEYjQQhELmrkec3Z6yh0M0u597arnMupXYNlZJiCww5D7OPXHOgHg7Ax7mnCNbvbaDvYSQNcVqZVe1ikeWxOhQdYz84rr8C1wgKLYlVt9Xcx71z4eIU5Ow3tdzMrLzQLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OkhCL2nJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334879ba28so2301086e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725015964; x=1725620764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez+BQcYiyANdMMi0AJGJySDJLmJdyeuHgv4xPkZjn2U=;
        b=OkhCL2nJpHaXGmqj1JDNCNCDPpQU8uxtk7mcaaORWI4EB9zSmSKuqnOp7fTBhL4KnY
         wsfYTNmP7cJlwM7tJVmASyjUuuGtsoNILXdGzbqmgkGs+lJUtzm2sIBIKYsHkZGgFkVb
         IWaviLuZo4met6FNhhNPoOhrH3avmwm1giehXk9E4J/94uJjXrb/WDZ48UbKzm6+gtRi
         DbBgt6ckMW8yj3CKT3Q5K2WIzHp3ZF2kmZ22F+n290XVezSMS/hlpExhZb5PpY7WMWXK
         nMwyPj53OCLMBWUTcdYQ47hijgEoxD36aGdhmsrosSugsmu4mYpzDMVmMytAv3UBbl/X
         WP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015964; x=1725620764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez+BQcYiyANdMMi0AJGJySDJLmJdyeuHgv4xPkZjn2U=;
        b=M0/TCSfDDZKjoelZBcigDrFAAw/x5d+ME30u0M1m2me9dmQe7ZWPSkVRoIuxBKqW9I
         dLEz0RmJ5r+diJ85Tm913iJYkdYgqscbNqbPeoDNGZfH8z6/GlQwISgucZIOWj1u+vrC
         yrc5uxZeP+QiBXH1p+wEr1pB5B8vOty+ioFpxiNt9DyjKwjlolf/VtkSqVgMiUu7qWGJ
         WW+uCF1lHUDWZM31n0V+6puDBd0xpni4/1RirU+DRYec8mcg5yZzSCnF7PgzO6BG7FQ9
         5C9colvuMb/KHVm7JEQut2G5p9qZ1IP0YNLuFRP3t+iE1QvZkEt2ctfu8SOeVm9mvZz1
         bj6A==
X-Forwarded-Encrypted: i=1; AJvYcCXj1UAI1c7BDjRFPjHmQyVTQIm46uyKEwgWSc34ICl0+sQDCWCLlMScsjdr5dy3gcr3l5sbo7F5CUP1XoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6IfowEkuVFthM2FJ7vYhyHq2m0NPBa7nLxPVtz9dCmt6OE2e
	Rkxq/3+aBsbsvt7IoknPh0ZS/PMgj6EZP+DZG07cvNZXxpWwqw0w3phuPf+lQ+FiaxphXdOIs1J
	U
X-Google-Smtp-Source: AGHT+IGMRbFIlp4AbwljhN1xCdqIp3HTZBud+tm58O+Ny5oEtzb4Hl6px/GsA3tIt0wHp1X4UhJtfg==
X-Received: by 2002:a05:6512:10cc:b0:530:b760:92b3 with SMTP id 2adb3069b0e04-53546b3fdc7mr1414741e87.31.1725015963606;
        Fri, 30 Aug 2024 04:06:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fea68dsm201315666b.26.2024.08.30.04.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:06:03 -0700 (PDT)
Date: Fri, 30 Aug 2024 13:06:01 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Willem de Bruijn <willemb@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, Tao Liu <thomas.liu@ucloud.cn>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
Message-ID: <hisntim4en6bh5ewqeaamirsq4f3ajax7f27dszntlqz3d3mz4@vkkkdvspxsu6>
References: <2024082224-CVE-2022-48936-9302@gregkh>
 <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
 <2024082854-reassign-uniformed-2c2f@gregkh>
 <jsnwzpmezgju7r7nkcauaicthkzizsqglb6p43zq25cdvdgbgt@dlkgwkch52qi>
 <CA+FuTSeHvADR5qbWnzRpYtpvNcvYrAeXAj8LYczUFLKREDwfpQ@mail.gmail.com>
 <2024082958-distress-outmatch-ab28@gregkh>
 <CA+FuTSdT9Xf0TZm9JAv5tC3WN0UYO_Y9bcAwSsiKyCtwehOE4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSdT9Xf0TZm9JAv5tC3WN0UYO_Y9bcAwSsiKyCtwehOE4g@mail.gmail.com>

On Thu, Aug 29, 2024 at 01:07:36PM GMT, Willem de Bruijn <willemb@google.com> wrote:
> With the fix backported to all these branches, not sure what, if
> anything, more is needed wrt the CVE.

My goal is to maintain some positive signal/noise in the assigned CVEs.

(Also, there are other kernel branches to evaluate as Greg says :-))

On Thu, Aug 29, 2024 at 12:53:34PM GMT, Willem de Bruijn <willemb@google.com> wrote:
> The patch reports that the negative effect is a drop due to a corrupted packet.
> 
> According to the CVE report this requires both user input with
> virtio_net_hdr, which is privileged, and a tunnel device configured,
> which again is privileged.

(Unless inside netns, I assume. Though...)
...that affects only scope of the same user, right? (The effect doesn't
cross boundary of any security domains.)

So far there is nothing in my (incomplete) understadning that would
classify this as a vulnerability (bugfix it is indeed).

Thanks,
Michal

