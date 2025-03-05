Return-Path: <linux-kernel+bounces-546803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9829A4FEE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB9B16939F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9724502F;
	Wed,  5 Mar 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMN41SVV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9884245014;
	Wed,  5 Mar 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178570; cv=none; b=IH+UfW071/GN14vz98a9G2UsDAEe4NCzdx53jPn7Nz8kmnx+J07hHolN4plyzxH7Wp1CTjTnY5VOuL6gBKJLG4lBUbMWxIPBybXfWWtc48bdeNfcGzassdHfCo+wOXOGJFKvOmzkZhMAvipjGRbs4yds3z3uAhG7qui6lz3szmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178570; c=relaxed/simple;
	bh=X2V0+L0ZtzvwVdxWLfa4UJaYCdttZkeI/fl3im7sUuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVt9qNcWHkdFByzGSpuegwvxanYeChF85ymN4ZemEQU/PMZcB+sYKLKdBAXWNXcHBje19IKnOmbzQwjII2dxTYr18+EjdNm9ZB7NU2lYReX+A8Dvz77A0x+N3ZZmQ9tSSVMrtghaLCwx7TGdzXXxdWBzxdmatIbMJTAeRrBSyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMN41SVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D97C4CEE7;
	Wed,  5 Mar 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741178569;
	bh=X2V0+L0ZtzvwVdxWLfa4UJaYCdttZkeI/fl3im7sUuU=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=NMN41SVVjBSnd83WUziYtIm3hloMBtDhlJv66UDvjXwa4JBLTvwZWZHTsncVGX9Hz
	 3T2DtrDoaKz4Bvj7Zd6ucKfHMVxq77zwvaU7ensrCpe8cLj0ATsrly5tak5xKr9G7k
	 KJHXOVehKdN3lkjijGjqEu7a16IfF5SWFoyKAk9sjdpY+50yx9xHvnHWFS37bTKBF0
	 mXmyk9Z4crudWemGmZh2JikNbmRqWfa1jyo2aEE9B+6H+u4dvotoc55fcd+Nrafcs0
	 8KaG3v07d5f5uHR95nlsn29/o7pMBDvh2t2GcLSx49LG013b+OhSgkNa1ECkkVupl+
	 SsLTwxtUmracw==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53a91756e5so5552021276.1;
        Wed, 05 Mar 2025 04:42:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURke7Yz6QvCd9DH15wrEdePJmW5wlr2YJPmf3hQg6PsxsL4V0A2U80zw9a06UHW8VcNJeLU4MB5NCOFqM=@vger.kernel.org, AJvYcCWSGHJkKzSuCH6wf+TBG0yQYkXUdbE+lsnBBmGEpu4tJ/pZCSK7EbxgJ+crpR3NHlQdtwwOU/V2CAyBBww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfvlpgzBsOVBWZsFY5fo+h7x1JAGDpt8S99x9DIdSGgIssERCO
	T8gUOqv32mJ+24PyEOQE0OdTEFlFgVFZukD24npyuKiZQUVWmxTs4Dlq8VU6Zi1vUAoYa4sLCdq
	tKMVI4XhW+pIwp0Te5Yqkgel3hGA=
X-Google-Smtp-Source: AGHT+IF/IlEIgRNaWFgM92b5tS9QsorbWNyQhg/scauhATQ3F5FsuAzlTcIMkPalMdjDDUIEX8cAAOQTRlN9FmFB92o=
X-Received: by 2002:a05:6902:1002:b0:e60:ad91:b1ac with SMTP id
 3f1490d57ef6-e611e193e97mr3438168276.11.1741178568573; Wed, 05 Mar 2025
 04:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305083103.16959-1-baojun.xu@ti.com>
In-Reply-To: <20250305083103.16959-1-baojun.xu@ti.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 5 Mar 2025 12:42:37 +0000
X-Gmail-Original-Message-ID: <CA+5PVA6bkUUxCyRNyW6Ebe=twC4wv+U1Z-aQ=-jx9fp0aTFwLg@mail.gmail.com>
X-Gm-Features: AQ5f1JpVMOC5gxo0WXGHKGZ--m2PcW2rgbyxw-PsM8crVXynJkEekOHmgIqY0CI
Message-ID: <CA+5PVA6bkUUxCyRNyW6Ebe=twC4wv+U1Z-aQ=-jx9fp0aTFwLg@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Update dsp firmware for Gemtree project
To: Baojun Xu <baojun.xu@ti.com>
Cc: shenghao-ding@ti.com, linux-firmware@kernel.org, 13916275206@139.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/465

josh

On Wed, Mar 5, 2025 at 8:31=E2=80=AFAM Baojun Xu <baojun.xu@ti.com> wrote:
>
> Update dsp firmware for Gemtree project,
> Add symbol link for old patch compatible.
>
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  WHENCE                     |   4 ++++
>  ti/tas2781/TAS2XXX8DE8.bin | Bin 49824 -> 49824 bytes
>  ti/tas2781/TAS2XXX8DE9.bin | Bin 49824 -> 49824 bytes
>  3 files changed, 4 insertions(+)
>
> diff --git a/WHENCE b/WHENCE
> index 5fd70d07..02b50c1f 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -8081,6 +8081,10 @@ Link: TAS2XXX103C8DE80.bin -> ti/tas2781/TAS2XXX8D=
E8.bin
>  Link: TAS2XXX103C8DE81.bin -> ti/tas2781/TAS2XXX8DE8.bin
>  Link: TAS2XXX103C8DE90.bin -> ti/tas2781/TAS2XXX8DE9.bin
>  Link: TAS2XXX103C8DE91.bin -> ti/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX103C8DE8-0.bin -> ti/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX103C8DE8-1.bin -> ti/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX103C8DE9-0.bin -> ti/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX103C8DE9-1.bin -> ti/tas2781/TAS2XXX8DE9.bin
>  Link: TAS2XXX10A40.bin -> ti/tas2781/TAS2XXX10A40.bin
>  Link: TAS2XXX10A41.bin -> ti/tas2781/TAS2XXX10A41.bin
>  Link: TAS2XXX11540.bin -> ti/tas2781/TAS2XXX11540.bin
> diff --git a/ti/tas2781/TAS2XXX8DE8.bin b/ti/tas2781/TAS2XXX8DE8.bin
> index 9df4de127574509b17dcb4b0deb915c61e0fda6e..9595bf18cfdb40b627ff398b9=
39bc1abcbdc4e88 100644
> GIT binary patch
> delta 5441
> zcmZ3`%DkYJ+0fL~)QExM(1Jx3i~cY$_%bjuG5`T1L;8WL!|ox5X7NU*21Z8a@rgMF
> z8Ht9*x<(T>>P?KF#>~dZw(&>0#N@>~j*}Ni8c!D2^_{FB^_`J%vV^n?6HCM7IB7AB
> z#+jP+^=3DV~08)deo)c^ngzvl5B-=3D;N;lC{DAp0|9N@~qCHin->}N72a*^F<6g`u4vo
> zFLV&<yY9hP{p9J%Qs+zR3``6a44fPcjfRn#b?25%Z=3DCu5X#LBryXtD98YVxGUctt~
> zA$AvHnE@foz-DoCFd$p1fz48^mI=3DtNU;$Y+d5^40eSl55^ZLUbdqK3@-&u#xaz<2R
> z6DvLPOsX|RW<JR8RjVH-c3De4<Fvce0K+i7Fg}QeiB%ofHgC1KauP&?^n#tw$H4$J
> z!}l4wB*<U}Y4>X|46_Wz2hlJw#^C-lpg0DB|EpH5o_t_x56kasrv)YlOf%sz+Ftlh
> z0Vo5)lP65`U_3DSsQh}3+-RLUla^do0nyoicd#t#+cN{3*yIfgB0y}ERlV48%9=3DE0
> zpeYR838o+l1pZ%OVE7sFd-<=3DX1zRB^z_iByZWaUA>%D&u{^<DoruH&W{6k9n+ra#^
> z|9dCQWN-%2c|nmr^Eoyz!6r7@M^Q$DQDj*m48s(|_#hf4HhF?#wQ5TJOS>tq{8id)
> zAU7QA{>31!{}+a9H}1-Bu|KW5*+A(5qY7W)9mgNC3>P@qXD(xqnIq32Yaq(vQ$34;
> z!LpwH<#H$X+vk%u2h6^~$ar8gubLhwW6NY4eFISX&(l|C1}6Q<Q}h$LeHncj7z{oD
> zE$i9D7(be6Ml%gcMjFjD7?~!nRNJ`40ay<Kt0RFHVA;pQz#z=3DP!Nnj15fg8Kh)FRp
> zD497-Hi=3D)%ICJuic-6^gb=3DY~pQmi5jIcLtCnJkcSUl3HMF*9yr+%%dCu~k#p#73(w
> zP~9+Ms;;(pPLxWke?B9jT&2R8oS&DLnO<6ySdy8a7mu~IIN5!r++@Q^63hjR1(SUy
> zDJTJRbqg>H0~-b+Tnr3iLJSNEiopDu!@wZ|YznZc4$GEfJ*edf^koSHFAoE@+=3Dfkz
> zia9V6x%Eij#^cRt+eaIZgd2~OdDSu|Pn>JQT*z2B`NUj@;n{;4%?G2MDEyr$a6aH&
> z*}=3D@r$UJ$*N@D7Z&2d}x7=3Dig^bKf>I#u3&vA7-U%;^e!#CDlF^5!FAJ*+W|Y9GtZ7
> pZn0q&WfYw(vlUdtjwYR9Gpa+6q{B5i`+(kLqeJSO4;*;F2mr+Vxz7Lq
>
> delta 5079
> zcmZ3`%DkYJIoQ<H)QExM&;nsGyFCmH-VBV43_!rhklxQ<;1Lk-o|;=3Dyl$shJ>=3D|ED
> znwOcE9-o*~kdbI;7++kHT9ld(S72xsZ)9L(YG7z&Ffn)$vp1vn#vkbtjI$;uNNO@S
> zFfdHMpd&JQfuu3x*~t>RK9d!szB4jRmXLN~0#b3(Vj4}0i|y;>k6vtCr82Mn|NsA0
> z=3DcNRjT7F5_R<k~BS(g5#?z+^=3Dnx<N%$qn;G44PMPx7UP!schBSGp)Y-=3Dd$Wp&%+E%
> z3>6HV91Q#JZ%Z=3DwJ$mEDuE|e92I-lov`u~>y@HL^YL6nsG6O=3DEfz9IPU_iE11DmB-
> zEfbJk!2+^u@*Y{0`Uq=3D%yX8kN90JjSPwUeT-E+K(O{`M%oM?0J+NmHX*AxY1x4kla
> z%@(@;1`NaW!uTK>CRS57XLoaBvMY!N=3D><EVkAned#^l9{Mw9Q(;1*yE?mq*HSs0jn
> zU}_J`AI5;_$pO<$cocxbAgtjj`)TroX&#IYlaI=3D;*T{;xdur-ZB{LA6(e(Ae@>wO3
> z*u*ApP!IuPqpU?$j_m^B%s`VE7+a!16bSsE8XEdD;`j33I$Iw>M1a!#?`ARZE^GV8
> zc%bs1j_VNy=3D9LX8?Qa81*4;Pn4pcY^qD%C8Vy7;geHWY9WFJKt4TgrGTQCe$4C8}n
> znAqeAiq)z=3D>R;MTapkYlW&^q5Sobdmaj^?9T&wBuwKY)b%4P$l2aGDbzcSYSSdj3G
> z{ixAthQ&2<49iZ=3DW$~$=3D#lT=3D$&)(d)m))|$V{^dl8^Fx6nYYb|bF#g@E+`@A=3D_@k=
>
> z)9~ae`ib0M8NV_x7<>R))w78)el#bH<^*6;7<oA%u9W$6lfz`53F?d-lTG3m18amE
> z@v6cN3=3DFziZTY~GiiLqygdyk5nX{7x67CBE!-#>I@i61z(Y!NSivZKY$f-r*IZ<km
> z{`riIg!797LvnszT4s7_QDRAEeqKDz7F&D>xb>#so1c;zZ(^a~?NJq9Y#47aS$~og
> zb0=3DfxWS>b2;EZa&Rd#qb$?8E(GGKXA!obVJfUO0FO^k}IGER82Z1Ms{Q}WtmH>YhM
> zZIcmhlTGGT%a}ZIt_gDjW5VPUa~(z#G`#CEnxKbbCj*?Ic~^EYYcpz3p0N_Sq~092
> zRgV#vz&H18Gh-aOZR}xIvL#NwyIWH2^K7EJoHBbz>vDoq!`&@5%r6;VPL|mUD&9s@
> c!C)M7phqg;nw)(=3D4><H-ct~yYfdda10nGYRVE_OC
>
> diff --git a/ti/tas2781/TAS2XXX8DE9.bin b/ti/tas2781/TAS2XXX8DE9.bin
> index 64c79d22679eec2654079334a6f8cf9c99065061..3eae6a36a1da341a38c05672d=
5770dc72840cc23 100644
> GIT binary patch
> delta 4098
> zcmZ3`%DkYJS>M#u)QExM(1Iefu0#d~Uj{}-1|VQ$NIx*o+dah4BHqZ<z{tovJ~5{t
> zBhk=3D!;zoms@za<?7(+JxNReV>og6DI9?<x2L0ElS+0I6pZ7KEt|NpO%xO1_|MN_wS
> z_qEF{DwEdMHEXNYMmXtoi3PKlzFhOO&n$IMZNlQnl8kS!Tg;d9SD%RZ*!JXSZJqd*
> zzG~*cFOwZs8BSg}Z!#+jcj!m36%mB2U|?dXVBqFpAla$}8I8#o=3D1*Y(Sv7f&tV(@=3D
> zO}X>>!yS7;wA<fVhtG0GRAUn>J@QPdHAH4U$ir2uA18KMOFrYYyVC%}FugE7h=3Dz$(
> z9oIH*wYYK;M1%B#UC+nC05l`?8M-9MU<PUTYcLG648{l1Ffqp9{xhKX1A+fnL&JWw
> zB<lax+4^|0z%-f37vwTnem5SdoE$JsQ=3DIGd-jw#Yfet{0M%xSDDFA8Z=3DacOxPnhPx
> zcwq8T`SlvP(K>e~ExD`$qO<?*U|H0+X9hO0$r}_zfY{LfU-e?gDQnW0fkrWKCzygL
> z5cq$Af#GMw@8!Rm7Hoxx0Mi%$yIBlCC;UD5qvP+J+RH%k51SPfkFYR0OlF*`&Uj!m
> zuUb4OFnQ(bt1tso*5oPriQI9FaSRLwAAo9mHZjJGCce?cw`T@D65r-2afwXa8H^dD
> zsSi>djuw5;;*dtEuMN5A+dQQ|i%A$uRXo{!rNU&xNfOMBjE$3hCOHhB%D5g>83XIY
> z5(Zu#25faNHZf`@O5_T8P}Ijar)?kD`gk(0TE^swb4{3m#o*)<b4L>!^%{Spi4DE+
> z2Tp9fD?6BL7;7faSP4vQn`5`?GXkmJZRU)lEp$)|eIQDN$qI@WH{ad;nHknf2S?Q1
> lEjG;i823$<**Y3gSh`Y!DWbS0XCKg;Y;;I{^ML~o7y-x+;!^+s
>
> delta 4146
> zcmZ3`%DkYJIoQ<H)QExM(1P!W4|+2&cr!3EG5`T1LwY~|Uyp!z_te~yqSVy*V9)rH
> z(!9*P^!UV_f{a8%!}#Ko)S}dUxB^3qcq0QNQv*XIgNeb5nCCOj-}oa%ijiq@th9K2
> z)8b<LdikRl8&|2!tN;K1f7N*@!KO1TT(!o(zqOid(XH$EepO@r|9NNJj|*iB*$sO3
> z<uKJL&lE0|{q?GO1$TQ*_?OC7tv%D~%YQDbj`cjuz{F6&z{$a|@BX$VbKj#kZtR-;
> z6lAWRiAq~@fyUyR{_C-=3DjjZqM^QDBU`R_CSoxEV)6joNNJ&MG+2W&n!2Lq|@BHle0
> z=3D1*Y(xo7eoS(W+-Ykj-rM=3Dl%!(Sc9v(+=3DHpyoyb%QuLf?bMM-zAg|UG1!cFrGJMSz
> zy8Z?X!}P-VAQ~oCQ#WUKb7QhAhz98edy$WW0cghL#fnCg@6O;BVGQm+1B!hZ_|cN6
> zKbdEm!sH8b87zMo1EMDfOw$w>GUiTce;eokRHXpL8lJMBCQq2=3D!RRpgsQh}3tf;%E
> zrY=3D=3D71JM~xUk@ywRT7C!Z1M&L5g<0S{~u`U=3D=3Dq788E6~>V@ni>0)hWiLqmT?{9gW=
B
> zXX_(~2vC~;-7E&)Wo`c$4^;lsaXrGoys}}lg5nVt#siZX=3Dc+R@Z01#q=3DLDv^TzwU0
> zV3M0WML&`IDC1EE27?bkGkP{L#*C&)T)AX4RRU8gJyPZ7DRGHR+@Bdgk0whZ3h&Wm
> zNxNj(hFn-~p3<MiB#E=3DypDZ{@YO>)Z3Fc15&dENL97bz*9IXvtf~^PD?!Zd6gn^fb
> z0b6B`O^k{aJSV({pS(cPlxo%c&1u^QwtAn;tClf&;#?Ev1jdBPC+3c(K|FQ&Xd0wV
> zWe!e*yem7Hf&HY(GgboA;O5w^`iwxTcbhrmuxic^M1G&Fpm=3Dff-QAy=3DVNH5)c;DS(
> o!+ePG&}5mdqu~wdQc<g+iYvUiCTAbe1Ez4pLu#839C*M80J;<78vp<R
>
> --
> 2.34.1
>

