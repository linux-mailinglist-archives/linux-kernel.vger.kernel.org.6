Return-Path: <linux-kernel+bounces-546295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D44A4F8DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F0A3AA3BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C831FCF7D;
	Wed,  5 Mar 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eI6yPVea"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA41D90DF;
	Wed,  5 Mar 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163500; cv=none; b=EQVYisBzTdmNTIte8pAFLRQ4hMR910XdGcRCS2xBwz7d0CatyD09QDtBKDOMOnmk1rcOnEn2hYQQWEk5sUiDnBrRyIj3tSQxYTVLTOlSB40vDcFAelyCpvT5GSE7PlnitdJPy+1gA3/JF8zx7bEwRDj48ODvJLiKAXs4HQuxebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163500; c=relaxed/simple;
	bh=mUnkFnH3bf3GBokL5Atwlh7Cz77TLFsgla6P3gk3i90=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oCzurVpjGTacAFF4n/t/XOhlxy7Y4L8lAvd7FQJdYQysrZGDVKNfplMvRJ979s4wb+TnKzYn3GXM/pC6ruC4Kwpb9IoJomlNvxJgkM4sAIor1H3HjqfK2CXWYXpDf/z2SZk7nRnKmeTndvHcAfCZ9rxE2hMNafetXLwr5txuyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eI6yPVea; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5258VU5H3818649
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 02:31:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741163491;
	bh=fYnThmWIQ/xerYWb+eioSgsFQFy6DXt3TtaWFxcYa6c=;
	h=From:To:CC:Subject:Date;
	b=eI6yPVea3cVMdw9QlqXjNdOBeeZBX9H/tkTimsg3HFz0xC38Opu7mGgzZLTgnA9bS
	 s5el3jaILBZ8U0TgdP2yIodV6t/bLCGbjlsrgAheBjvZ+QNcyGZ4DRa8uZq9L+l09L
	 FdGLCbrGDw6qK0zx1t+TOfyNy1hd4J4xa2I3CEuk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5258VUxi013256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 02:31:30 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 02:31:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 02:31:30 -0600
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5258VQNL111251;
	Wed, 5 Mar 2025 02:31:27 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <jwboyer@kernel.org>
CC: <shenghao-ding@ti.com>, <linux-firmware@kernel.org>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Baojun Xu <baojun.xu@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Update dsp firmware for Gemtree project
Date: Wed, 5 Mar 2025 16:31:03 +0800
Message-ID: <20250305083103.16959-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update dsp firmware for Gemtree project,
Add symbol link for old patch compatible.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 WHENCE                     |   4 ++++
 ti/tas2781/TAS2XXX8DE8.bin | Bin 49824 -> 49824 bytes
 ti/tas2781/TAS2XXX8DE9.bin | Bin 49824 -> 49824 bytes
 3 files changed, 4 insertions(+)

diff --git a/WHENCE b/WHENCE
index 5fd70d07..02b50c1f 100644
--- a/WHENCE
+++ b/WHENCE
@@ -8081,6 +8081,10 @@ Link: TAS2XXX103C8DE80.bin -> ti/tas2781/TAS2XXX8DE8.bin
 Link: TAS2XXX103C8DE81.bin -> ti/tas2781/TAS2XXX8DE8.bin
 Link: TAS2XXX103C8DE90.bin -> ti/tas2781/TAS2XXX8DE9.bin
 Link: TAS2XXX103C8DE91.bin -> ti/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX103C8DE8-0.bin -> ti/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX103C8DE8-1.bin -> ti/tas2781/TAS2XXX8DE8.bin
+Link: TAS2XXX103C8DE9-0.bin -> ti/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX103C8DE9-1.bin -> ti/tas2781/TAS2XXX8DE9.bin
 Link: TAS2XXX10A40.bin -> ti/tas2781/TAS2XXX10A40.bin
 Link: TAS2XXX10A41.bin -> ti/tas2781/TAS2XXX10A41.bin
 Link: TAS2XXX11540.bin -> ti/tas2781/TAS2XXX11540.bin
diff --git a/ti/tas2781/TAS2XXX8DE8.bin b/ti/tas2781/TAS2XXX8DE8.bin
index 9df4de127574509b17dcb4b0deb915c61e0fda6e..9595bf18cfdb40b627ff398b939bc1abcbdc4e88 100644
GIT binary patch
delta 5441
zcmZ3`%DkYJ+0fL~)QExM(1Jx3i~cY$_%bjuG5`T1L;8WL!|ox5X7NU*21Z8a@rgMF
z8Ht9*x<(T>>P?KF#>~dZw(&>0#N@>~j*}Ni8c!D2^_{FB^_`J%vV^n?6HCM7IB7AB
z#+jP+^=V~08)deo)c^ngzvl5B-=;N;lC{DAp0|9N@~qCHin->}N72a*^F<6g`u4vo
zFLV&<yY9hP{p9J%Qs+zR3``6a44fPcjfRn#b?25%Z=Cu5X#LBryXtD98YVxGUctt~
zA$AvHnE@foz-DoCFd$p1fz48^mI=tNU;$Y+d5^40eSl55^ZLUbdqK3@-&u#xaz<2R
z6DvLPOsX|RW<JR8RjVH-c3De4<Fvce0K+i7Fg}QeiB%ofHgC1KauP&?^n#tw$H4$J
z!}l4wB*<U}Y4>X|46_Wz2hlJw#^C-lpg0DB|EpH5o_t_x56kasrv)YlOf%sz+Ftlh
z0Vo5)lP65`U_3DSsQh}3+-RLUla^do0nyoicd#t#+cN{3*yIfgB0y}ERlV48%9=E0
zpeYR838o+l1pZ%OVE7sFd-<=X1zRB^z_iByZWaUA>%D&u{^<DoruH&W{6k9n+ra#^
z|9dCQWN-%2c|nmr^Eoyz!6r7@M^Q$DQDj*m48s(|_#hf4HhF?#wQ5TJOS>tq{8id)
zAU7QA{>31!{}+a9H}1-Bu|KW5*+A(5qY7W)9mgNC3>P@qXD(xqnIq32Yaq(vQ$34;
z!LpwH<#H$X+vk%u2h6^~$ar8gubLhwW6NY4eFISX&(l|C1}6Q<Q}h$LeHncj7z{oD
zE$i9D7(be6Ml%gcMjFjD7?~!nRNJ`40ay<Kt0RFHVA;pQz#z=P!Nnj15fg8Kh)FRp
zD497-Hi=)%ICJuic-6^gb=Y~pQmi5jIcLtCnJkcSUl3HMF*9yr+%%dCu~k#p#73(w
zP~9+Ms;;(pPLxWke?B9jT&2R8oS&DLnO<6ySdy8a7mu~IIN5!r++@Q^63hjR1(SUy
zDJTJRbqg>H0~-b+Tnr3iLJSNEiopDu!@wZ|YznZc4$GEfJ*edf^koSHFAoE@+=fkz
zia9V6x%Eij#^cRt+eaIZgd2~OdDSu|Pn>JQT*z2B`NUj@;n{;4%?G2MDEyr$a6aH&
z*}=@r$UJ$*N@D7Z&2d}x7=ig^bKf>I#u3&vA7-U%;^e!#CDlF^5!FAJ*+W|Y9GtZ7
pZn0q&WfYw(vlUdtjwYR9Gpa+6q{B5i`+(kLqeJSO4;*;F2mr+Vxz7Lq

delta 5079
zcmZ3`%DkYJIoQ<H)QExM&;nsGyFCmH-VBV43_!rhklxQ<;1Lk-o|;=yl$shJ>=|ED
znwOcE9-o*~kdbI;7++kHT9ld(S72xsZ)9L(YG7z&Ffn)$vp1vn#vkbtjI$;uNNO@S
zFfdHMpd&JQfuu3x*~t>RK9d!szB4jRmXLN~0#b3(Vj4}0i|y;>k6vtCr82Mn|NsA0
z=cNRjT7F5_R<k~BS(g5#?z+^=nx<N%$qn;G44PMPx7UP!schBSGp)Y-=d$Wp&%+E%
z3>6HV91Q#JZ%Z=wJ$mEDuE|e92I-lov`u~>y@HL^YL6nsG6O=Efz9IPU_iE11DmB-
zEfbJk!2+^u@*Y{0`Uq=%yX8kN90JjSPwUeT-E+K(O{`M%oM?0J+NmHX*AxY1x4kla
z%@(@;1`NaW!uTK>CRS57XLoaBvMY!N=><EVkAned#^l9{Mw9Q(;1*yE?mq*HSs0jn
zU}_J`AI5;_$pO<$cocxbAgtjj`)TroX&#IYlaI=;*T{;xdur-ZB{LA6(e(Ae@>wO3
z*u*ApP!IuPqpU?$j_m^B%s`VE7+a!16bSsE8XEdD;`j33I$Iw>M1a!#?`ARZE^GV8
zc%bs1j_VNy=9LX8?Qa81*4;Pn4pcY^qD%C8Vy7;geHWY9WFJKt4TgrGTQCe$4C8}n
znAqeAiq)z=>R;MTapkYlW&^q5Sobdmaj^?9T&wBuwKY)b%4P$l2aGDbzcSYSSdj3G
z{ixAthQ&2<49iZ=W$~$=#lT=$&)(d)m))|$V{^dl8^Fx6nYYb|bF#g@E+`@A=_@k>
z)9~ae`ib0M8NV_x7<>R))w78)el#bH<^*6;7<oA%u9W$6lfz`53F?d-lTG3m18amE
z@v6cN3=FziZTY~GiiLqygdyk5nX{7x67CBE!-#>I@i61z(Y!NSivZKY$f-r*IZ<km
z{`riIg!797LvnszT4s7_QDRAEeqKDz7F&D>xb>#so1c;zZ(^a~?NJq9Y#47aS$~og
zb0=fxWS>b2;EZa&Rd#qb$?8E(GGKXA!obVJfUO0FO^k}IGER82Z1Ms{Q}WtmH>YhM
zZIcmhlTGGT%a}ZIt_gDjW5VPUa~(z#G`#CEnxKbbCj*?Ic~^EYYcpz3p0N_Sq~092
zRgV#vz&H18Gh-aOZR}xIvL#NwyIWH2^K7EJoHBbz>vDoq!`&@5%r6;VPL|mUD&9s@
c!C)M7phqg;nw)(=4><H-ct~yYfdda10nGYRVE_OC

diff --git a/ti/tas2781/TAS2XXX8DE9.bin b/ti/tas2781/TAS2XXX8DE9.bin
index 64c79d22679eec2654079334a6f8cf9c99065061..3eae6a36a1da341a38c05672d5770dc72840cc23 100644
GIT binary patch
delta 4098
zcmZ3`%DkYJS>M#u)QExM(1Iefu0#d~Uj{}-1|VQ$NIx*o+dah4BHqZ<z{tovJ~5{t
zBhk=!;zoms@za<?7(+JxNReV>og6DI9?<x2L0ElS+0I6pZ7KEt|NpO%xO1_|MN_wS
z_qEF{DwEdMHEXNYMmXtoi3PKlzFhOO&n$IMZNlQnl8kS!Tg;d9SD%RZ*!JXSZJqd*
zzG~*cFOwZs8BSg}Z!#+jcj!m36%mB2U|?dXVBqFpAla$}8I8#o=1*Y(Sv7f&tV(@=
zO}X>>!yS7;wA<fVhtG0GRAUn>J@QPdHAH4U$ir2uA18KMOFrYYyVC%}FugE7h=z$(
z9oIH*wYYK;M1%B#UC+nC05l`?8M-9MU<PUTYcLG648{l1Ffqp9{xhKX1A+fnL&JWw
zB<lax+4^|0z%-f37vwTnem5SdoE$JsQ=IGd-jw#Yfet{0M%xSDDFA8Z=acOxPnhPx
zcwq8T`SlvP(K>e~ExD`$qO<?*U|H0+X9hO0$r}_zfY{LfU-e?gDQnW0fkrWKCzygL
z5cq$Af#GMw@8!Rm7Hoxx0Mi%$yIBlCC;UD5qvP+J+RH%k51SPfkFYR0OlF*`&Uj!m
zuUb4OFnQ(bt1tso*5oPriQI9FaSRLwAAo9mHZjJGCce?cw`T@D65r-2afwXa8H^dD
zsSi>djuw5;;*dtEuMN5A+dQQ|i%A$uRXo{!rNU&xNfOMBjE$3hCOHhB%D5g>83XIY
z5(Zu#25faNHZf`@O5_T8P}Ijar)?kD`gk(0TE^swb4{3m#o*)<b4L>!^%{Spi4DE+
z2Tp9fD?6BL7;7faSP4vQn`5`?GXkmJZRU)lEp$)|eIQDN$qI@WH{ad;nHknf2S?Q1
lEjG;i823$<**Y3gSh`Y!DWbS0XCKg;Y;;I{^ML~o7y-x+;!^+s

delta 4146
zcmZ3`%DkYJIoQ<H)QExM(1P!W4|+2&cr!3EG5`T1LwY~|Uyp!z_te~yqSVy*V9)rH
z(!9*P^!UV_f{a8%!}#Ko)S}dUxB^3qcq0QNQv*XIgNeb5nCCOj-}oa%ijiq@th9K2
z)8b<LdikRl8&|2!tN;K1f7N*@!KO1TT(!o(zqOid(XH$EepO@r|9NNJj|*iB*$sO3
z<uKJL&lE0|{q?GO1$TQ*_?OC7tv%D~%YQDbj`cjuz{F6&z{$a|@BX$VbKj#kZtR-;
z6lAWRiAq~@fyUyR{_C-=jjZqM^QDBU`R_CSoxEV)6joNNJ&MG+2W&n!2Lq|@BHle0
z=1*Y(xo7eoS(W+-Ykj-rM=l%!(Sc9v(+=Hpyoyb%QuLf?bMM-zAg|UG1!cFrGJMSz
zy8Z?X!}P-VAQ~oCQ#WUKb7QhAhz98edy$WW0cghL#fnCg@6O;BVGQm+1B!hZ_|cN6
zKbdEm!sH8b87zMo1EMDfOw$w>GUiTce;eokRHXpL8lJMBCQq2=!RRpgsQh}3tf;%E
zrY==71JM~xUk@ywRT7C!Z1M&L5g<0S{~u`U==q788E6~>V@ni>0)hWiLqmT?{9gWB
zXX_(~2vC~;-7E&)Wo`c$4^;lsaXrGoys}}lg5nVt#siZX=c+R@Z01#q=LDv^TzwU0
zV3M0WML&`IDC1EE27?bkGkP{L#*C&)T)AX4RRU8gJyPZ7DRGHR+@Bdgk0whZ3h&Wm
zNxNj(hFn-~p3<MiB#E=ypDZ{@YO>)Z3Fc15&dENL97bz*9IXvtf~^PD?!Zd6gn^fb
z0b6B`O^k{aJSV({pS(cPlxo%c&1u^QwtAn;tClf&;#?Ev1jdBPC+3c(K|FQ&Xd0wV
zWe!e*yem7Hf&HY(GgboA;O5w^`iwxTcbhrmuxic^M1G&Fpm=ff-QAy=VNH5)c;DS(
o!+ePG&}5mdqu~wdQc<g+iYvUiCTAbe1Ez4pLu#839C*M80J;<78vp<R

-- 
2.34.1


