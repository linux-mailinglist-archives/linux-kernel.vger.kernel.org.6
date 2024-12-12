Return-Path: <linux-kernel+bounces-442821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D99EE273
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153E5282A73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21120E014;
	Thu, 12 Dec 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jK/FkF2N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997B2594BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994971; cv=none; b=oowZyhAo7xNwUxY0K06mcqshFDGjO6KBLVC2Cd1ZH+E6p0lb7iVqF0V3n+jgpv3gMTbZxicw3sGMxUjWbxKpud8FBpXZZZsNAhKvxiSrucIWLhbbQMUzVIF0ndSfvKs3OtUP/jKdfH6nqjnvWka8mXz1VLIrgsJ5RYDIkMAlxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994971; c=relaxed/simple;
	bh=dHeloRYBZqsQ8YzyY7XBOB5omPuvszkfJNuWwK6lNHY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=V1nKW6s2oJkWqLLTh5HWvyMXBlGuej4FLRyciP+7m6aT2THD7dG2qpmG2sTlfMOrGcTZJ3tuF36Ac0SAAmYHfbya6bbcgD7GbTiVftBnKcMP3/uEWJnHNLGCwbSMncBN+q4YLcYliFmAPN3vCFBfPZ3mZFaVEXLBg+cWNg6JfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jK/FkF2N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733994970; x=1765530970;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=dHeloRYBZqsQ8YzyY7XBOB5omPuvszkfJNuWwK6lNHY=;
  b=jK/FkF2NZxZ/V1eKM9LvlVbloUgFxFVw6YHUjP1yW+TFqR1ukY9IkNbR
   mG7DHArxeqX8MzNlLAnuIBWJQxkdo7SP88XTh0cFggoLA0EOaOymJXtnX
   Oo99fvcYrFifla87Qx7cPcVQp0PZlh2WCXlAdmOrFvMfwh14FqMGYuheQ
   l6CQtBO+3LvHTCkB+zwPy8cIIrBdtFq6AmdWIEX83UHt6gmLGZnVKlZlp
   +MFO7LJ0VuEPtzXoWWg75sg25tDsM3Ki5pTr6Cv5APz8iNPS6XD1va5OJ
   m6zW3DFGuhUOzEZU2uTIQwMk7uEFEZ5jg8hPSaMTECxI4DQXqsZALl+/D
   g==;
X-CSE-ConnectionGUID: R1h12SjoTbCc1eDn68GHNg==
X-CSE-MsgGUID: fAoKRdeMS76OloLOf9Vxtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="45012966"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="45012966"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:16:09 -0800
X-CSE-ConnectionGUID: m2CkNjQTSoK0df2r8N+k6Q==
X-CSE-MsgGUID: 04tjzyQ5Tq++r5Fz+HHSxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="95928861"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:16:05 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z1fDsvIKB4j_-Tv_@infradead.org>
References: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com> <20241209133318.1806472-2-mika.kuoppala@linux.intel.com> <Z1fDsvIKB4j_-Tv_@infradead.org>
Subject: Re: [PATCH 01/26] ptrace: export ptrace_may_access
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, christian.koenig@amd.com, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Matthew Brost <matthew.brost@intel.com>, Andi Shyti <andi.shyti@intel.com>, Maciej Patelczyk <maciej.patelczyk@linux.intel.com>, Dominik Grzegorzek <dominik.grzegorzek@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>, Mika Kuoppala <mika.kuoppala@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Thu, 12 Dec 2024 11:16:02 +0200
Message-ID: <173399496234.20348.12425394481969055234@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.10

Quoting Christoph Hellwig (2024-12-10 06:29:38)
> On Mon, Dec 09, 2024 at 03:32:52PM +0200, Mika Kuoppala wrote:
> > xe driver would like to allow fine grained access control
> > for GDB debugger using ptrace. Without this export, the only
> > option would be to check for CAP_SYS_ADMIN.
> >=20
> > The check intended for an ioctl to attach a GPU debugger
> > is similar to the ptrace use case: allow a calling process
> > to manipulate a target process if it has the necessary
> > capabilities or the same permissions, as described in
> > Documentation/process/adding-syscalls.rst.
> >=20
> > Export ptrace_may_access function to allow GPU debugger to
> > have identical access control for debugger(s)
> > as a CPU debugger.
>=20
> This seems to mis an actual user or you forgot to Cc linux-kernel on it.

Right, that is a miss on our side. For the time being, the whole series
can be found in lore archive:

https://lore.kernel.org/dri-devel/20241209133318.1806472-1-mika.kuoppala@li=
nux.intel.com/

The user is introduced in patch: [PATCH 03/26] drm/xe/eudebug: Introduce di=
scovery for resources [1]

Essentially, we want to check if PID1 has permission to ptrace PID2, before=
 we grant the
permission for PID1 to debug the GPU address space/memory of PID2.

Mika, please do Cc the relevant other patches of the series to LKML for nex=
t iteration.

Regards, Joonas

[1] https://lore.kernel.org/dri-devel/20241209133318.1806472-1-mika.kuoppal=
a@linux.intel.com/T/#md3d005faaaac1ba01451b139a634e5545c2a266f

