Return-Path: <linux-kernel+bounces-356262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D515D995EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093F71C22D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962B154BF0;
	Wed,  9 Oct 2024 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="h75XvDhq"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC438DD3;
	Wed,  9 Oct 2024 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449330; cv=none; b=jWiTJoSGRkKaeMCunsmFQs5RtuTkvN1plhY4w/Cd1+MWMbb2POI0SkPtRSdd1eYdOj14T5HZmFW9qwKpo3rUNH86Xpq4iYpaku6tRHI/xhmCJSIxPlJTIFBOHwVPs7nFl0RDUaCswQrTSXyZUlLR4KFMntAkg46A2h0LDh7Qbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449330; c=relaxed/simple;
	bh=yFK4ktE6kLrFlQGaWot3ZmVU8EcL7gA5Ck2suiHl4OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXfdtZHPqy3jIgCwNaqK0yAKyHKL/z5JQRwvxy+/C3xnSVSlL1RQduLCcMSf53ZfGvAAi0rvMI3Pt5Sh2YjARoxbqU1QtSzB9fPnmtbvlML3lVzystfJ3h7budtxxa7/TKLIG8UizdGQv+J7y50BmqkLlmfymG6hm1XIl8X+JtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=h75XvDhq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728449323;
	bh=uMgzHaq2PtarSf76t5H+hReShTblmOAvj1JQqJCeCbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h75XvDhqBZJCnvzjFqZfVOueIrPpfavGyVgtKj2u9a4OeIBCKTJ1gCp1xj0+BlxwN
	 ppV3gFWMmkaE9WJADlMOSdGAzC0EvDtwYpNRMM+/Uqw2uaYzZiQ1j0H6zaNYFa7ja4
	 dFSXpdOx5zt6SD0+PtNop/4heFxNFFFqrgbDiMlocS7AQBran98c25ltHeeI7EUbQx
	 Rnwim5/UJ1n0vAHHQC3H/OIvDpTyPFbZst1zF0GzvUyU+DPAurJn0cD4tiUWcNe19d
	 4VilVP5dJ5O+i5DjI9DDI+nKbp/Zdp1ePAKAM0MDxxr+BlEChLl6sd04rR7PGV6/ks
	 TQvSqrdO6kvyw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNgQ21zPlz4wnr;
	Wed,  9 Oct 2024 15:48:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Markus Elfring
 <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org, Jani Nikula
 <jani.nikula@intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Naveen
 N Rao <naveen@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Paul
 Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] powermac: Call of_node_put(bk_node) only once in
 pmac_has_backlight_type()
In-Reply-To: <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
 <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
Date: Wed, 09 Oct 2024 15:48:42 +1100
Message-ID: <87cyk97ufp.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 02/10/2024 =C3=A0 22:02, Markus Elfring a =C3=A9crit=C2=A0:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 2 Oct 2024 21:50:27 +0200
>>=20
>> An of_node_put(bk_node) call was immediately used after a pointer check
>> for an of_get_property() call in this function implementation.
>> Thus call such a function only once instead directly before the check.
>
> It seems pointless to perform a put immediately after a get. Shouldn't=20
> of_find_property() be used instead ? And then of_property_read_string()=20
> would probably be better.
>
> Maybe you can even use of_property_match_string().

Yes that would clean it up nicely I think, eg:

int pmac_has_backlight_type(const char *type)
{
        struct device_node* bk_node =3D of_find_node_by_name(NULL, "backlig=
ht");
        int i;

        i =3D of_property_match_string(bk_node, "backlight-control", type);
        of_node_put(bk_node);

        return i >=3D 0;
}

cheers

