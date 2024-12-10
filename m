Return-Path: <linux-kernel+bounces-439944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FB9EB691
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D3D1633C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636C22FE08;
	Tue, 10 Dec 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="P1uLGjs3"
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA61BDABE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848508; cv=none; b=hzMNzWXVZEEIDS7AESEi2dww/2FVlVjSmcuF+HF5Z1RousmwGPuA90hXIZW9S+ngBu3qTlUk4UUTG4LRjkR/yR86iGL8AUzE5QkKjonX0KJ19gSV1ZWl5zUqIv9dW6NasHAlaXH0ypfcZNuAAcVjMQb4tsKoU5k+dRle+Gr0gAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848508; c=relaxed/simple;
	bh=fdvYQhF/kSEp4gq64e8K5HKCp1kndZOw+47KYZU0gr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgZbazmFWo+Vt7Wv9zkgdqTwDSexnGDbjzPzvkarLKreLC59yJUMothY4gxaiRuSoMNbzpUyfCmbriBOydUAWHahhFfmEd/dxtBUD8BUt2cXWic+d1tqin/j1vNm1FDYUDA34zfgdxU/3gsABU0VcTzl9QKS/6QpMA5Wd0Mljdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=P1uLGjs3; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y748G5G7KzGl;
	Tue, 10 Dec 2024 17:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733848494;
	bh=kASgsG6sXiEfr28LEqS8qaRwPSmOUOfc00ok9X/mxlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1uLGjs3VUUQIlzlcmipATpKvMZD4jznCWyMtOe2pGbtLOJ6br2AhrxIGsvjr0Z4c
	 qZOV/k8aWswDT5U2MKfBwkv8soMPNTgM4Kx685QCorRMBy8TlwAt8/BA4f5CtzWHz+
	 D5KuTOr6/JdEvz2zhceJgScwnuSBHni0WI2RrzYI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y748F6xQbz78s;
	Tue, 10 Dec 2024 17:34:53 +0100 (CET)
Date: Tue, 10 Dec 2024 17:34:42 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org, 
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	audit@vger.kernel.org
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <20241210.Wie6ion7Aich@digikod.net>
References: <20241204192514.40308-1-zohar@linux.ibm.com>
 <282573d0ea82ac71c8305d0c8cc89083@paul-moore.com>
 <b6dc4d8b23b822638ab676055809503060c0bca2.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6dc4d8b23b822638ab676055809503060c0bca2.camel@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Thu, Dec 05, 2024 at 10:10:36PM -0500, Mimi Zohar wrote:
> On Thu, 2024-12-05 at 19:30 -0500, Paul Moore wrote:
> > On Dec  4, 2024 Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > 
> > > Like direct file execution (e.g. ./script.sh), indirect file execution
> > > (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> > > the new security_bprm_creds_for_exec() hook to measure and verify the
> > > indirect file's integrity.  Unlike direct file execution, indirect file
> > > execution is optionally enforced by the interpreter.
> > > 
> > > Differentiate kernel and userspace enforced integrity audit messages.
> > > 
> > > Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > > Changelog v3:
> > > - Mickael: add comment ima_bprm_creds_for_exec(), minor code cleanup,
> > >   add Co-developed-by tag.
> > > 
> > > Changelog v2:
> > > - Mickael: Use same audit messages with new audit message number
> > > - Stefan Berger: Return boolean from is_bprm_creds_for_exec()
> > > 
> > >  include/uapi/linux/audit.h            |  1 +
> > >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
> > >  security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
> > >  3 files changed, 55 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > index 75e21a135483..826337905466 100644
> > > --- a/include/uapi/linux/audit.h
> > > +++ b/include/uapi/linux/audit.h
> > > @@ -161,6 +161,7 @@
> > >  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
> > >  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
> > >  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> > > +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data integrity */
> > 
> > I worry that "DATA_CHECK" is a bit vague, should we change the name so
> > that there is some hint of either userspace enforcement or
> > AT_EXECVE_CHECK?
> > 
> > What about AUDIT_INTEGRITY_DATA_USER?
> 
> The emphasis should be on userspace - AUDIT_INTEGRITY_USERSPACE.

Looks good, I'll send a new patch series with this change, following
https://lore.kernel.org/all/20241205160925.230119-9-mic@digikod.net/

